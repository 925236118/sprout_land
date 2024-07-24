shader_type canvas_item;

uniform vec2 light_pos = vec2(0, 0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 pixel_pos = TEXTURE_PIXEL_SIZE * UV;
	vec2 normal = pixel_pos - light_pos;
	COLOR = vec4(0, 0, 0, 1);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
