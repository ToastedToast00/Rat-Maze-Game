extends Control

func _ready() -> void:
	$Pause.pressed.connect(_on_pause_pressed)
	$VBoxContainer.visible = false
	# $VBoxContainer/Menu.pressed.connect(_on_menu_pressed)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

func _on_resume_pressed() -> void:
	get_tree().paused = false
	$VBoxContainer.visible = false
	$Pause.visible = true


func _on_pause_pressed() -> void:
	get_tree().paused = true
	$Pause.visible = false
	$VBoxContainer.visible = true
