extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_0.tscn")
	pass

func _on_options_pressed() -> void:
	#TODO: make options accessable as a instance to
	#      make menu useable outside of menu
	get_tree().change_scene_to_file("res://scenes/menu/settings.tscn")
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
