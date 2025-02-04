extends RayCast3D
class_name WheelRayCast

signal wheel_colliding

@onready var car: RigidCar = $".."

var previous_spring_length : float = 0.0

func _physics_process(delta: float) -> void:
	if is_colliding():
		# initial reference: https://www.youtube.com/watch?v=fe-8J7_WAq0
		# NEEDS WORK
		var susp_dir = global_basis.y
		
		var raycast_origin = global_position
		var raycast_dest = get_collision_point()
		var distance = raycast_dest.distance_to(raycast_origin)
		
		var contact = get_collision_point() - car.global_position
		
		var spring_length = clamp(distance - car.wheel_radius, 0, car.suspension_rest_dist)
		
		var spring_force = car.spring_strength * (car.suspension_rest_dist - spring_length)
		
		var spring_velocity = (previous_spring_length - spring_length) / delta
		
		var damper_force = car.spring_damper * spring_velocity
		
		var suspension_force = basis.y * (spring_force + damper_force)
		
		previous_spring_length = spring_length
		
		var point = Vector3(raycast_dest.x, raycast_dest.y + car.wheel_radius, raycast_dest.z)
		
		car.apply_force(susp_dir * suspension_force , point - car.global_position)
	
	pass
