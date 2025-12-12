extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_0.tscn")
	pass

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/settings.tscn")
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()
