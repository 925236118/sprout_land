extends Control
@onready var option_button: OptionButton = $HBoxContainer/OptionButton
const FARMING_PLANTS = preload("res://assets/Sprout Lands - Sprites - premium pack/Objects/Items/Farming Plants items.png")

func _on_hoe_pressed() -> void:
	GlobalTool.current_tool = "hoe"

func _on_axe_pressed() -> void:
	GlobalTool.current_tool = "axe"

func _on_kettle_pressed() -> void:
	GlobalTool.current_tool = "kettle"

func _on_seed_pressed() -> void:
	GlobalTool.current_tool = "seed"

func _ready() -> void:
	for index in GlobalPlants.plants.size():
		var plant = GlobalPlants.plants[index]
		var image = FARMING_PLANTS.get_image()

		var plant_image = image.get_region(Rect2i(
			Vector2i(0, (index + 1) * 16),
			Vector2i(16, 16)
		))

		var texture = ImageTexture.create_from_image(plant_image)

		var plant_name = plant.name

		option_button.add_icon_item(texture, plant_name, index)

func _on_option_button_item_selected(index: int) -> void:
	GlobalTool.current_tool = "seed"
	GlobalPlants.current_plant = index
