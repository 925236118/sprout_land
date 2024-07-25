extends Node

signal dig_earth(pos: Vector2)
signal plant_plant(pos: Vector2)
signal water_earth(pos: Vector2)

signal update_earth_map_tiles
signal update_plants_map_life

var current_plant: int = 0

var watered_pos: Array[Vector2i] = []

func _ready() -> void:
	plant_loop()

func plant_loop():
	await get_tree().create_timer(1).timeout
	update_plants_map_life.emit()
	plant_loop()

func clear_water_earth():
	watered_pos = []
	update_earth_map_tiles.emit()

var plants = [
	{
		"name": "玉米",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 1),
				"require_time": 1
			},
			{
				"coord": Vector2i(1, 1),
				"require_time": 1
			},
			{
				"coord": Vector2i(2, 1),
				"require_time": 1
			},
			{
				"coord": Vector2i(3, 0),
				"require_time": 1
			},
			{
				"coord": Vector2i(4, 0),
				"require_time": 1
			},
		]
	},
	{
		"name": "胡萝卜",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 2),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 2),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 2),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 2),
				"require_time": 3
			},
		]
	},
	{
		"name": "菜花",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 3),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 3),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 3),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 3),
				"require_time": 3
			},
		]
	},
	{
		"name": "豌豆",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 4),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 4),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 4),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 4),
				"require_time": 3
			},
		]
	},
	{
		"name": "茄子",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 5),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 5),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 5),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 5),
				"require_time": 3
			},
		]
	},
	{
		"name": "蓝玫瑰",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 6),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 6),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 6),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 6),
				"require_time": 3
			},
		]
	},
	{
		"name": "白菜",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 7),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 7),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 7),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 7),
				"require_time": 3
			},
		]
	},
	{
		"name": "小麦",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 8),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 8),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 8),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 8),
				"require_time": 3
			},
		]
	},
	{
		"name": "南瓜",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 9),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 9),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 9),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 9),
				"require_time": 3
			},
		]
	},
	{
		"name": "萝卜",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 10),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 10),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 10),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 10),
				"require_time": 3
			},
		]
	},
	{
		"name": "大花",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 11),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 11),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 11),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 11),
				"require_time": 3
			},
		]
	},
	{
		"name": "芜菁",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 12),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 12),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 12),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 12),
				"require_time": 3
			},
		]
	},
	{
		"name": "杨桃",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 13),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 13),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 13),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 13),
				"require_time": 3
			},
		]
	},
	{
		"name": "黄瓜",
		"source_id": 0,
		"life": [
			{
				"coord": Vector2i(0, 14),
				"require_time": 3
			},
			{
				"coord": Vector2i(1, 14),
				"require_time": 3
			},
			{
				"coord": Vector2i(2, 14),
				"require_time": 3
			},
			{
				"coord": Vector2i(3, 14),
				"require_time": 3
			},
		]
	},
]

