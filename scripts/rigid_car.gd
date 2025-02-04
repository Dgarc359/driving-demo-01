extends RigidBody3D
class_name RigidCar

@onready var wheel_br: WheelRayCast = $WheelBR
@onready var wheel_fr: WheelRayCast = $WheelFR
@onready var wheel_fl: WheelRayCast = $WheelFL
@onready var wheel_bl: WheelRayCast = $WheelBL





# EXAMPLE
func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var forward_local_axis: Vector3 = Vector3(1, 0, 0)
	var forward_dir: Vector3 = (current_transform.basis * forward_local_axis).normalized()
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	# this line doesnt work OOB
	#var local_speed: float = clampf(speed, 0, acos(forward_dir.dot(target_dir)))
	#if forward_dir.dot(target_dir) > 1e-4:
		#state.angular_velocity = local_speed * forward_dir.cross(target_dir) / state.step
	
	pass


func _ready():
	
	
	#for wheel in wheels:
		#if wheel:
			#wheel.wheel_colliding.connect(float)
	pass

func float_vehicle(state: PhysicsDirectBodyState3D, current_transform: Transform3D):
	print('floooatiitngngngngn')
	var upward_local_axis: Vector3 = Vector3(0,1,0)
	var upward_dir: Vector3 = (current_transform.basis * upward_local_axis).normalized()
	#var target_dir: Vector3 = (upward_dir + current_transform.origin).normalized()
	state.angular_velocity = 4 * upward_dir / state.step
	pass




func _integrate_forces(state:  PhysicsDirectBodyState3D):
	var space_state = get_world_3d().direct_space_state
	#pass
	
	#var target_position = $my_target_node3d_node.global_transform.origin
	#look_follow(state, global_transform, target_position)
	var wheels: Array[WheelRayCast] = [
		wheel_br,
		wheel_fr,
		wheel_fl,
		wheel_bl
	]
	
	for wheel in wheels:
		if wheel and wheel.is_colliding:
			float_vehicle(state, global_transform)
	
	pass
