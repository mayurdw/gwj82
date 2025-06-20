shader_type canvas_item;

uniform bool active = false;
uniform float intensity: hint_range(0.0, 1.0, 0.1) = 1.0;
uniform vec4 tint : source_color = vec4(1., 1., 0., 1);

void vertex() {
	if (active) {
		VERTEX.x += sin(TIME * intensity * 100.0 + VERTEX.y);
	}
}

void fragment() {
	if (active && intensity > 0.0)	{
		vec4 tint_copy = tint;
		tint_copy.a = intensity;
		vec4 previous_color = texture(TEXTURE, UV);

		tint_copy.a = previous_color.a;
		COLOR = tint_copy;
	}
}