shader_type canvas_item;

uniform vec3 color_added: source_color = vec3(0, 0, 1);
uniform float amount: hint_range(0, 1) = 0.5;

void fragment() {
//	COLOR /= 2.;
//	COLOR = texture(TEXTURE, UV);
	COLOR.rgb += color_added * amount;
//	COLOR = vec4(0.5);
}
