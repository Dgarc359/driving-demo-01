extends RigidBody3D

@export var pivot: Node3D

@export var mouse_sensivity = 0.5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	pass
	if event is InputEventMouseMotion:
		#rotate_y(deg_to_rad(-event.relative.x * mouse_sensivity))
		#pivot.rotate_x(deg_to_rad(event.relative.y * mouse_sensivity))
		pivot.rotate_y(deg_to_rad(event.relative.x * mouse_sensivity))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(45))


func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	apply_impulse(direction)
	
	pass
