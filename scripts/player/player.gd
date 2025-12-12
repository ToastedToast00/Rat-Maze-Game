extends CharacterBody3D

#
@onready var cameraGrouping = get_node("cameraGrouping")
# Movement speeds
#TODO: after swapping forward/backward swap 0.5 and 1.0
var forwardMovement := 0.5
var backwardMovement := 1.0

# Movement direction
var direction := Vector3.ZERO

# Needed for camera movement while FP
var savedRotationY := 0.0
var wasFrontFacing := false

#contains movement logic AND First Person Edge Case
func _process(_delta: float) -> void:
	var isFrontFacing : bool = cameraGrouping.isFrontFacingActive()
	# restrictions for first person
	if cameraGrouping.isFrontFacingActive():
		#Disable movement
		velocity.x = 0
		velocity.z = 0
		move_and_slide()
		return

	#Detect toggle into first-person
	if isFrontFacing and not wasFrontFacing:
		savedRotationY = rotation.y
	#Detect toggle back to thrid-person
	if not isFrontFacing and wasFrontFacing:
		rotation.y = savedRotationY

	wasFrontFacing = isFrontFacing

	if isFrontFacing:
		var camera_basis = cameraGrouping.frontFacingCamera.global_transform.basis
		var camera_yaw = camera_basis.get_euler().y
		rotation.y = camera_yaw

	if isFrontFacing:
		rotation.y = cameraGrouping.get_yaw()

	# Reset horizontal velocity
	velocity.x = 0
	velocity.z = 0

	# Forward/Backward movement
	#TODO: figure out why moveBackward and moveForward is inverted
	var forwardPressed := Input.is_action_pressed("moveBackward")
	var backwardPressed := Input.is_action_pressed("moveForward")

	if forwardPressed and not backwardPressed:
		var forwardVector := -Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity += forwardVector * forwardMovement
	elif backwardPressed and not forwardPressed:
		var backwardVector := Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity += backwardVector * backwardMovement
	# If both are pressed, velocity stays zero (handled above)

	# Left/Right rotation
	if Input.is_action_pressed("turnRight"):
		rotation.y -= 0.01
	if Input.is_action_pressed("turnLeft"):
		rotation.y += 0.01

	# Apply movement
	move_and_slide()
