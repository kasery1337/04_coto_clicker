extends Control

func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_save_and_exit_button_pressed() -> void:
	Global.save_game()


func _on_load_button_pressed() -> void:
	Global.load_game()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
