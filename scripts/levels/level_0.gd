extends Node3D

func _ready() -> void:
	# Make sure the Area3D is connected to this function
	var area = $LevelTrigger/Area3D
	if area and not area.body_entered.is_connected(_on_area_3d_body_entered):
		area.body_entered.connect(_on_area_3d_body_entered)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		# Change to the next scene
		get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
