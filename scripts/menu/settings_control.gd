extends VBoxContainer


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
	pass # Replace with function body.


func _on_confirm_setting_pressed() -> void:
	print("Confirm!")
	pass # Replace with function body.
