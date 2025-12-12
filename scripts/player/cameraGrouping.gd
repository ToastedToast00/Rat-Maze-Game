extends XROrigin3D
#initialization of cameras
var topDownCamera: XRCamera3D
var frontFacingCamera: XRCamera3D
var activeCamera: XRCamera3D

var yaw := 0.0
var pitch := 0.0
const PITCH_LIMIT := deg_to_rad(89)

func _ready():
	topDownCamera = get_node_or_null("topDownCamera")
	frontFacingCamera = get_node_or_null("frontFacingCamera")

	if topDownCamera and frontFacingCamera:
		activeCamera = topDownCamera
		updateCameraStates()
	else:
		push_error("One or both camera nodes not found. Check node names and paths.")

func _process(_delta):
	if Input.is_action_just_pressed("cameraToggle") and topDownCamera and frontFacingCamera:
		toggleCamera()
	
	if isFrontFacingActive():
		handle_look_input(_delta)

func handle_look_input(delta):
	var look_input = Vector2(
		Input.get_action_strength("lookRight") - Input.get_action_strength("lookLeft"),
		Input.get_action_strength("lookDown") - Input.get_action_strength("lookUp")
	)
	
	var sensitivity := 1.5
	
	yaw -= look_input.x * sensitivity * delta
	pitch = clamp(pitch - look_input.y * sensitivity * delta, -PITCH_LIMIT, PITCH_LIMIT)

	# Apply rotation to the front-facing camera
	if frontFacingCamera:
		frontFacingCamera.rotation = Vector3(pitch, yaw, 0)



func toggleCamera():
	activeCamera = frontFacingCamera if activeCamera == topDownCamera else topDownCamera
	updateCameraStates()

func updateCameraStates():
	topDownCamera.current = activeCamera == topDownCamera
	frontFacingCamera.current = activeCamera == frontFacingCamera

#restricted camera usage for movement
func isFrontFacingActive() -> bool:
	return activeCamera == frontFacingCamera
