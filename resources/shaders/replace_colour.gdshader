shader_type canvas_item;

uniform float tolerance: hint_range(0.0, 1.0, 0.01) = 0.1;
uniform vec4 color_to_be_replaced[4]: source_color;
uniform vec4 new_colors[4]: source_color;
uniform float radius: hint_range(0.0, 1.5, 0.1) = 0.5;

uniform bool is_active = false;

void vertex() {
	if (is_active) {
		VERTEX.x += sin(TIME * 10.0 + VERTEX.y) * 1.0;
	}
}

void fragment() {
	if (is_active) {
		float dist = distance(vec2(0.0, 0.0), UV);
		if (dist < radius) {
			vec4 color = texture(TEXTURE, UV);
			vec4 initial_color = color;

			for( int i = 0; i < 4; i++ ) {
				if (color_to_be_replaced[i].a > 0.0) {
					float color_distance = distance(color_to_be_replaced[i], color);

				    if (color_distance <= tolerance) {
						color = mix(new_colors[i], color, color_distance);
						color.a = initial_color.a;
				    }

				    COLOR = color;
				}
			}
		}
	}
}
