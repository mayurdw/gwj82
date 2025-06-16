//shader_type canvas_item;
//
//uniform float tolerance: hint_range(0.0, 1.0, 0.01) = 0.1;
//uniform vec4 color_to_be_replaced[4]: source_color;
//uniform vec4 new_colors[4]: source_color;
//uniform bool is_active = false;
//
//void fragment() {
	//if (is_active) {
		//vec4 color = texture(TEXTURE, UV);
		//vec4 initial_color = color;
//
		//for( int i = 0; i < 4; i++ ) {
//
			//if (color_to_be_replaced[i].a > 0.0) {
				//float color_distance = distance(color_to_be_replaced[i], color);
//
			    //if (color_distance <= tolerance) {
					//color = mix(new_colors[i], color, color_distance);
					//color.a = initial_color.a;
			    //}
//
			    //COLOR = color;
			//}
		//}
	//}
//}

shader_type canvas_item;

uniform vec2 position;
uniform float radius;
uniform float borderWidth = 0.02;
uniform float burnMult = 0.135;
uniform sampler2D noiseTexture;
uniform vec4 burnColor : source_color;

void fragment() {
	float dist = length(position - UV) + (texture(noiseTexture, UV).b) * burnMult;
	COLOR.rgb = mix(COLOR.rgb, burnColor.rgb, float(dist<radius+borderWidth));
	COLOR.a *= 1.0-(float(dist<radius));
}