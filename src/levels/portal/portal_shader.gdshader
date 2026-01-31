shader_type canvas_item;

uniform float swirl_strength = 1.3;
uniform float swirl_speed = 2.0;
uniform vec4 red_color : source_color = vec4(1.0, 0.1, 0.1, 1.0);

void fragment() {
	vec2 uv = UV * 2.0 - 1.0;
	float r = length(uv);
	float angle = atan(uv.y, uv.x);
	
	angle += r * swirl_strength + TIME * swirl_speed;
	
	float swirl = sin(angle * 3.0) * 0.5 + 0.5;
	
	vec4 color = mix(vec4(0.0, 0.0, 0.0, 1.0), red_color, swirl);
	
	float alpha = smoothstep(1.0, 0.6, r);
	COLOR = vec4(color.rgb, alpha);
}

void vertex() {
	// Called for every vertex the material is visible on.
}



//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
