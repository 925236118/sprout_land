shader_type canvas_item;

uniform vec4 select_skin_color : source_color = vec4(0, 0, 0, 1);
uniform vec4 skin_color : source_color = vec4(0, 0, 0, 1);
uniform vec4 select_stroke_color : source_color = vec4(0, 0, 0, 1);
uniform vec4 stroke_color : source_color = vec4(0, 0, 0, 1);


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	if (pixel_color == select_skin_color) {
		COLOR = skin_color;
	} else if (pixel_color == select_stroke_color) {
		COLOR = stroke_color;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
