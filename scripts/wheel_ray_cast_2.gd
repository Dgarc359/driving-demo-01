extends RayCast3D

# reference https://www.youtube.com/watch?v=6hEL66P1WQw
class_name WheelController

@export var wheel_radius: float = 0.35

#@onready var wheel : Node3D = get_node("Wheel")
# This script is already being attached to a raycast 3D, so there's no need to
# grab a reference to one, just refernce self as needed
#@onready var ray : RayCast3D = get_node("RayCast3D")

var max_spring_length : float
var spring_stiffness : float
var spring_damping : float
var force: Vector3
var offset : Vector3
var previous_spring_compression : float
var current_spring_compression : float
var spring_compression_length_at_rest : float
var wheel_position : Vector3
var spring_velocity : float

var groups: Array[StringName]


func init_suspension(rest_force: float, arg_max_spring_length: float, arg_spring_stiffness: float, arg_spring_damping: float):
	groups = get_groups()
	max_spring_length = arg_max_spring_length
	spring_stiffness = arg_spring_stiffness
	spring_damping = arg_spring_damping
	
	# the wheel radius shouldn't give us a wheel bigger than our available spring
	# otherwise, we get a negative target_position
	# In reality, it's definitely possible to have a wheel radius > max spring length (monster trucks)
	# But because we're deriving target_position for the raycast from wheel_radius
	# we need to have some constraints... This seems like a spot for improvement
	assert(wheel_radius <= max_spring_length) 
	
	target_position = Vector3(0, -(max_spring_length - wheel_radius), 0)
	cprint("logger", ['ray target position', target_position])
	previous_spring_compression = 0
	cprint("logger", ['rest force', rest_force])
	cprint("logger", ['spring stiffness', spring_stiffness])
	spring_compression_length_at_rest = rest_force / spring_stiffness
	cprint("logger", ['spring compression length at rest', spring_compression_length_at_rest])
	
	# just cache the groups we're in so we don't need to keep checking
	# this is something that should be set at runtime
	

# conditional print, based on node group
func cprint(group: String, args):
	if groups.has(group):
		var str_to_print = " ".join(args.map(func (v): return str(v)))
		print(str_to_print)
	pass


func apply_spring_force(delta: float, vehicle: RigidCar, vehicle_rotation: Quaternion):
	if is_colliding():
		var contact_point: Vector3 = get_collision_point()
		var contact_point_vehicle: Vector3 = vehicle.to_local(contact_point)
		current_spring_compression = contact_point_vehicle.y - wheel_radius
		if previous_spring_compression != 0:
			var compression_diff = current_spring_compression - previous_spring_compression
			cprint("logger", ["compression diff", compression_diff])
			spring_velocity = compression_diff / delta
		else:
			spring_velocity = 0
		
		cprint("logger", ["spring velocity:", spring_velocity ])
		cprint("logger", ['previous spring compression', previous_spring_compression])
		cprint("logger", ['current spring compression', current_spring_compression])
		previous_spring_compression = current_spring_compression
		
		var spring_compression = spring_compression_length_at_rest - previous_spring_compression
		
		cprint("logger", [
			"spring compression", spring_compression
		])
		
		# f = k * x (hooke's law) says that force = K * X where K is some positive real number
		# characteristic of a spring
		# X should be how much our spring has compressed
		# 							K ??			X
		var spring_force: float = spring_stiffness * spring_compression # Hooke's law
		
		
		var damped_velocity: float = spring_damping * spring_velocity
		cprint("logger", [
			"current spring force", spring_force, 
			"damping force", spring_damping, 
			'spring velocity', spring_velocity, 
			"damped velocity", damped_velocity, 
			"spring compression", spring_compression
		])
		
		var upward_force = spring_force + damped_velocity
		cprint("logger", ['upward force: ', upward_force])
		force = Vector3(0, upward_force, 0)
		#offset = vehicle_rotation * contact_point_vehicle
		offset = contact_point - vehicle.global_position
		vehicle.apply_force(force, offset)
		wheel_position = Vector3(0, previous_spring_compression, 0)
	else:
		previous_spring_compression = 0
		# TODO, sign on max_spring_length was flipped here
		wheel_position = Vector3(0, max_spring_length, 0)
	
	# TODO
	# wheel.transform.origin = wheel_position
	pass
