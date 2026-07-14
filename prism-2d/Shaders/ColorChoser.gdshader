shader_type canvas_item;

// This shader is borrowed from Godot Shaders by MikeFozzy98 - https://godotshaders.com/shader/color-replacer/
// I made a couple adjustments to fix a glitch and to make it work for Prism
// - onewingd

//Main Color
uniform vec4 main_color : source_color;
uniform vec4 main_replace_color : source_color;
uniform float main_color_threshold : hint_range(0.0, 1.0, 0.001);

//Accent Color
uniform vec4 accent_color : source_color;
uniform vec4 accent_replace_color : source_color;
uniform float accent_color_threshold : hint_range(0.0, 1.0, 0.001);


void fragment() {
	// Called for every pixel the material is visible on.
	vec4 tex_color = texture(TEXTURE, UV);
	
	if (tex_color.a == 0.0) {
		discard;
	}
	
	float main_distance = length(tex_color.rgb - main_color.rgb);
	float accent_distance = length(tex_color.rgb - accent_color.rgb);

	if(main_distance < main_color_threshold){
		tex_color = main_replace_color;
	}else if(accent_distance < accent_color_threshold){
		tex_color = accent_replace_color;
	}
	
	COLOR = tex_color;
}