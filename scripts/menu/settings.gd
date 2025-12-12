extends Control

@onready var keybindButton : Button = $settings/settings_control/keyBind
@onready var inputMappingBox : VBoxContainer = $settings/input_control

func _on_keyBind_pressed() -> void:
	inputMappingBox.visible = not inputMappingBox.visible
