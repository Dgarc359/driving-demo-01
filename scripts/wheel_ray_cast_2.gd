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
var spring_rest_distance : float
var wheel_position : Vector3
var spring_velocity : float


func init_suspension(rest_force: float, arg_max_spring_length: float, arg_spring_stiffness: float, arg_spring_damping: float):
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
	print('ray target position: ', target_position)
	previous_spring_compression = 0
	print('rest force ', rest_force)
	print('spring stiffness ', spring_stiffness)
	spring_rest_distance = rest_force / spring_stiffness
	print('spring rest distance: ', spring_rest_distance)

func apply_spring_force(delta: float, vehicle: RigidCar, vehicle_rotation: Quaternion):
	if is_colliding():
		var contact_point: Vector3 = get_collision_point()
		var contact_point_vehicle: Vector3 = vehicle.to_local(contact_point)
		current_spring_compression = contact_point_vehicle.y - wheel_radius
		if previous_spring_compression != 0:
			spring_velocity = (current_spring_compression - previous_spring_compression) / delta
		else:
			spring_velocity = 0
		
		previous_spring_compression = current_spring_compression
		
		# f = k * x (hooke's law) says that force = K which is some positive real number
		# characteristic of a spring
		# X should be how much our spring has compressed
		# 							K ??			X
		var spring_force: float = spring_stiffness * (spring_rest_distance - previous_spring_compression) # Hooke's law
		
		
		var damping_force: float = spring_damping * spring_velocity
		var upward_force = spring_force + damping_force
		print('upward force: ', upward_force)
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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
