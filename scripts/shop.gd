extends Control
@export var coin_label: Button
@export var upgrade_container: VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_purchased_upgrades()

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/main.tscn')

func update_ui() -> void:
	coin_label.text = str(Global.coins)

func close_button(name_button: NodePath):
	var button = get_node(name_button) as Button
	if button:
		button.disabled = true
		if not Global.purchased_upgrades.has(name_button):
			Global.purchased_upgrades.append(name_button)

func check_purchased_upgrades() -> void:
	coin_label.text = str(Global.coins)
	for button_path in Global.purchased_upgrades:
		var button = get_node_or_null(button_path) as Button
		if button:
			button.disabled = true


func _on_button_pressed(extra_arg_0: NodePath) -> void:
	if Global.can_afford(150):
		Global.spend_coins(150)
		Global.auto_coin = true
		update_ui()
		close_button(extra_arg_0)


func _on_bybutton_pressed(extra_arg_0: NodePath, extra_arg_1: int, extra_arg_2: int) -> void:
	if Global.can_afford(extra_arg_1):
		Global.spend_coins(extra_arg_1)
		Global.coins_per_click = extra_arg_2
		close_button(extra_arg_0)

func _on_lucky_button_pressed() -> void:
	# 1. Проверяем, есть ли у игрока хотя бы 10 монет
	if Global.coins >= 10:
		Global.coins -= 10 # Забираем плату за вход
		
		# 2. Самая простая магия: получаем случайное число от 0 до 30
		var prize = randi_range(0, 30) 
		Global.coins += prize # Добавляем выигрыш игроку
		
		# 3. Обновляем текст с балансом (замените на имя вашей функции обновления UI)
		update_ui() 
		
		# Выводим результат в консоль для проверки
		print("Вы потратили 10$, а выиграли: ", prize, "$")
	else:
		print("Недостаточно денег!")
