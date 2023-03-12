shader_type canvas_item;

uniform vec3 red_channel: source_color = vec3(1., 0., 0.);
uniform vec3 green_channel: source_color = vec3(0., 1., 0.);
uniform vec3 blue_channel: source_color = vec3(0., 0., 1.);
uniform float red_weight: hint_range(0.0, 10.0) = 1;
uniform float green_weight: hint_range(0.0, 10.0) = 1;
uniform float blue_weight: hint_range(0.0, 10.0) = 1;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

void fragment() {
//	vec3 color_sum = COLOR.r * red_channel + COLOR.g * green_channel + COLOR.b * blue_channel;
//	COLOR.rgb = color_sum;
//	COLOR.rgb = color_sum/3.;
//	vec3 color_sum = COLOR.r * red_channel + COLOR.g * green_channel + COLOR.b * blue_channel;
//	COLOR.rgb = color_sum;
//	COLOR.rgb = mix(vec3(0, 0, 0), red_channel, COLOR.r);
//	COLOR.rgb =  mix(COLOR.r * red_channel, green_channel, (COLOR.g+COLOR.r)/2.);
//	COLOR.rgb =  mix(mix(COLOR.r * red_channel, green_channel, COLOR.g), blue_channel, COLOR.b);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR.rgb *= vec3(red_weight, green_weight, blue_weight);
	float total = max(1, COLOR.r + COLOR.g + COLOR.b);
	COLOR.rgb = red_channel*COLOR.r/total + green_channel*COLOR.g/total + blue_channel*COLOR.b/total;
//	COLOR = vec4(0, 0, 0, 1);
//	COLOR.rg = vec2(0, 0.5) * vec2(0, 0.5);
}
