extends Control
@onready var item_texture: TextureRect = $ItemTexture
@onready var item_quantity: Label = $ItemQuantity


func set_texture(texture: Texture2D):
	item_texture.texture = texture
	
func set_quantity(quantity: int):
	if quantity == 0:
		item_quantity.text = ""
	else:
		item_quantity.text = "%d" % quantity
