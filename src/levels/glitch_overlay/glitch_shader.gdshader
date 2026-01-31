shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// burst behavior
uniform float base_strength = 0.01;
uniform float burst_strength = 0.06;
uniform float burst_duration = 0.25; // seconds of burst life
uniform float burst_interval = 2.0;  // seconds between burst checks

// visual style
uniform float block_size = 55.0;
uniform float color_shift = 3.0;
uniform float flash_power = 0.25;

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    float t = TIME;

    // ===== burst system with real duration =====
    float cycle_id = floor(t / burst_interval);
    float cycle_time = mod(t, burst_interval);

    // decide if this cycle has a burst
    float trigger = step(0.7, rand(vec2(cycle_id, 3.17)));

    // burst envelope over time
    float burst_env = smoothstep(burst_duration, 0.0, cycle_time);

    float burst = trigger * burst_env;

    float strength = mix(base_strength, burst_strength, burst);

    vec2 uv = SCREEN_UV;

    // block displacement
    float y_block = floor(uv.y * block_size);
    float x_shift = (rand(vec2(y_block, t*40.0)) - 0.5) * strength * 8.0;
    uv.x += x_shift * burst;

    // wave jitter
    uv.x += sin(uv.y*90.0 + t*70.0) * strength * 0.02 * burst;

    // RGB split
    vec2 r_off = vec2(strength * color_shift, 0.0);
    vec2 b_off = vec2(-strength * color_shift, 0.0);

    vec2 uv_r = clamp(uv + r_off, vec2(0.001), vec2(0.999));
    vec2 uv_g = clamp(uv,         vec2(0.001), vec2(0.999));
    vec2 uv_b = clamp(uv + b_off, vec2(0.001), vec2(0.999));

    float r = texture(SCREEN_TEXTURE, uv_r).r;
    float g = texture(SCREEN_TEXTURE, uv_g).g;
    float b = texture(SCREEN_TEXTURE, uv_b).b;

    vec3 cyber = vec3(r,g,b);

    // scan stripe flicker
    float stripe = step(0.93, fract(uv.y * 130.0 + t * 15.0));
    cyber = mix(cyber, cyber + 0.2, stripe * burst);

    // spark flashes
    float spark = rand(floor(uv*200.0) + floor(t*60.0));
    cyber += step(0.99, spark) * flash_power * burst;

    vec4 base = texture(SCREEN_TEXTURE, SCREEN_UV);
    vec3 final_col = mix(base.rgb, cyber, 0.75 * burst);

    COLOR = vec4(clamp(final_col, 0.0, 1.0), 1.0);
}
