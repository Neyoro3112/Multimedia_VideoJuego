shader_type canvas_item;

uniform sampler2D dissolve_texture : source_color;
uniform float dissolve_value : hint_range(0,1);
uniform float burn_size: hint_range(0.0, 1.0, 0.01);
uniform vec4 burn_color: source_color;

uniform vec2 sprite_sheet_size = vec2(288, 128);
uniform vec2 frame_size = vec2(32, 32);

void fragment(){
	vec4 main_texture = texture(TEXTURE, UV);
	
	vec2 current_point = sprite_sheet_size * UV;
	float row = floor(current_point.y / frame_size.y);
	float column = floor(current_point.x / frame_size.x);
	vec2 max_point = (frame_size * vec2(column, row)) + frame_size;
	vec2 new_uv = 1. - (max_point - current_point) / frame_size;
	
	vec4 noise_texture = texture(dissolve_texture, new_uv);
	
	// This is needed to avoid keeping a small burn_color dot with dissolve being 0 or 1
	// is there another way to do it?
	if (dissolve_value < 1.) {
		float burn_size_step = burn_size * step(0.001, dissolve_value) * step(dissolve_value, 0.999);
		float threshold = smoothstep(noise_texture.x-burn_size_step, noise_texture.x, dissolve_value);
		float border = smoothstep(noise_texture.x, noise_texture.x + burn_size_step, dissolve_value);
		
		COLOR.a *= threshold;
		COLOR.rgb = mix(burn_color.rgb, main_texture.rgb, border);
		
	}
}