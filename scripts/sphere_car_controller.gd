extends RigidBody3D

@export var speed = 4


# This sphere will receive the forces
#@onready var sphere: RigidBody3D = $Sphere

# This is just the 3d model being overlaid on top of the sphere
@onready var vehicle_godot_suv: Node3D = $"vehicle-suv2"
@onready var camera_3d: Camera3D = $"../Camera3D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


#func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	#var forward_local_axis: Vector3 = Vector3(1, 0, 0)
	#var forward_dir: Vector3 = (current_transform.basis * forward_local_axis).normalized()
	#var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	#var local_speed: float = clampf(speed, 0, acos(forward_dir.dot(target_dir)))
	#if forward_dir.dot(target_dir) > 1e-4:
		#state.angular_velocity = local_speed * forward_dir.cross(target_dir) / state.step

func _integrate_forces(state: PhysicsDirectBodyState3D):
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.y, 0, - input_dir.x)).normalized()
	
	# forward direction for camera... which is negative Z for the subject of the camera
	# the basis means that we're getting the outer transform... remember the whole thing about
	# gimbals and rotations....
	var camera_dir := - camera_3d.transform.basis.z
	
	state.angular_velocity = 4 * camera_dir.cross(direction) / state.step
	#state.velocity.x = 4 * direction.x
	#print(state.velocity)
	
	#var target_position = $my_target_node3d_node.global_transform.origin
	#look_follow(state, global_transform, target_position)
