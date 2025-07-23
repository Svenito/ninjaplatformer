shader_type canvas_item;

uniform bool flash_enabled = false;
uniform vec4 flash_colour : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 texture_colour = texture(TEXTURE, UV);
	vec4 output_colour = texture_colour;
	if (flash_enabled) {
		output_colour = mix(texture_colour, flash_colour, abs(texture_colour.a));
	}
	COLOR = output_colour;
}
