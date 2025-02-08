extends RayCast3D

# reference https://www.youtube.com/watch?v=6hEL66P1WQw
class_name WheelController

@export var wheel_radius: float = 0.35

#@onready var wheel : Node3D = get_node("Wheel")
# This script is already being attached to a raycast 3D, so there's no need to
# grab a reference to one, just refernce self as needed
#@onready var ray : RayCast3D = get_node("RayCast3D")

var spring_distance_max : float
var spring_constant : float
var spring_damping : float
var force: Vector3
var offset : Vector3
var spring_distance : float
var spring_distance_now : float
var spring_rest_distance : float
var wheel_position : Vector3
var spring_velocity : float


func init_suspension(rest_force: float, arg_spring_distance_max: float, arg_spring_constant: float, arg_spring_damping: float):
	spring_distance_max = arg_spring_distance_max
	spring_constant = arg_spring_constant
	spring_damping = arg_spring_damping
	target_position = Vector3(0, -(wheel_radius + spring_distance_max), 0)
	spring_distance = 0
	spring_rest_distance = rest_force / spring_constant

func apply_spring_force(delta: float, vehicle: RigidCar, vehicle_rotation: Quaternion):
	if is_colliding():
		var contact_point: Vector3 = get_collision_point()
		var contact_point_vehicle: Vector3 = vehicle.to_local(contact_point)
		spring_distance_now = contact_point_vehicle.y - wheel_radius
		if spring_distance != 0:
			spring_velocity = (spring_distance_now - spring_distance) / delta
		else:
			spring_velocity = 0
		
		var min_threshold = 0.1
		if abs(spring_distance_now) < min_threshold and abs(spring_velocity) < min_threshold:
			spring_distance_now = 0
			spring_velocity = 0
		
		spring_distance = spring_distance_now
		
		var spring_force: float = spring_constant * (spring_rest_distance - spring_distance) # Hooke's law
		
		var damping_force: float = spring_damping * spring_velocity
		force = Vector3(0, spring_force + damping_force, 0)
		#offset = vehicle_rotation * contact_point_vehicle
		offset = contact_point - vehicle.global_position
		vehicle.apply_force(force, offset)
		wheel_position = Vector3(0, spring_distance, 0)
	else:
		spring_distance = 0
		wheel_position = Vector3(0, -spring_distance_max, 0)
	
	# TODO
	# wheel.transform.origin = wheel_position
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
