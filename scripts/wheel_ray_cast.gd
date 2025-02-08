extends RayCast3D
class_name WheelRayCast

@onready var car: RigidCar = $".."

var previous_spring_length : float = 0.0

func _physics_process(delta: float) -> void:
	if is_colliding():
		# initial reference: https://www.youtube.com/watch?v=fe-8J7_WAq0
		# NEEDS WORK
		
		var node_name = $".".name
		
		# Grab UP direction
		var susp_dir = global_basis.y
		# Find raycast position in scene
		# Useful because we'll get the collision position
		# And figure out how far apart those two are
		var raycast_origin = global_position
		var raycast_dest = get_collision_point()
		# distance is the length to the collision point on the raycast..
		var distance = raycast_dest.distance_to(raycast_origin)


		# Not used for anything atm
		#var contact = raycast_dest - car.global_position
		
		print('FOR WHEEL: ', node_name)
		print('raycast origin: ', raycast_origin)
		print('raycast dest: ', raycast_dest)
		print('distance: ', distance)
		print('car suspension full length: ', car.suspension_full_length)
		
		# What we want to know here is how long the ACTUAL spring is, without the wheel's lift
		var spring_length_minus_wheel_radius = distance - car.wheel_radius
		
		var spring_length = clamp(spring_length_minus_wheel_radius, 0, car.suspension_full_length)
		# print('clamped length', spring_length)
		var spring_force = car.spring_strength * (car.suspension_full_length - spring_length_minus_wheel_radius)
		
		var spring_velocity = (previous_spring_length - spring_length) / delta
		
		var damper_force = car.spring_damper * spring_velocity
		print('damper force', damper_force)
		
		var suspension_force = basis.y * (spring_force + damper_force)
		
		previous_spring_length = spring_length
		
		var point = Vector3(raycast_dest.x, raycast_dest.y + car.wheel_radius, raycast_dest.z)
		
		car.apply_force(susp_dir * suspension_force , point - car.global_position)
	
	pass
