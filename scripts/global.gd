extends Node
@onready var coins_label: Label = $MarginContainer/VBoxContainer/HBoxContainerclick/PanelContainer/Label

var coins: int = 0
var coins_per_click: int = 1
var auto_coin = false
var purchased_upgrades: Array[String] = []

func add_coins(amount: int) -> void:
	coins += amount
	if coins > 999: coins = 0

func can_afford(price: int) -> bool:
	return coins >= price

func spend_coins(price: int) -> bool:
	if not can_afford(price):
		return false
	coins -= price
	return true
	
const SAVE_PATH: String = 'user://clicker_save.json'

func save_game() -> void:
	var save_data: Dictionary = {
		'coins': coins,
		'coins_per_click': coins_per_click,
		'auto_coin': auto_coin,
		'purchased_upgrades': purchased_upgrades
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null: return
	file.store_string(JSON.stringify(save_data))

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH): return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null: return
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY: return
	coins = int(parsed.get('coins', 0))
	coins_per_click = int(parsed.get('coins_per_click', 1))
	auto_coin = parsed.get('auto_coin', false)
	var raw_upgrades = parsed.get('purchased_upgrades', [])
	purchased_upgrades = Array(raw_upgrades, TYPE_STRING, &'', null)
	get_tree().change_scene_to_file('res://scenes/main.tscn')
