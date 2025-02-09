extends RigidBody3D
class_name RigidCar

@onready var wheel_br: WheelController = $WheelBR
@onready var wheel_fr: WheelController = $WheelFR
@onready var wheel_bl: WheelController = $WheelBL
@onready var wheel_fl: WheelController = $WheelFL


# reference for these vars: https://www.youtube.com/watch?v=6hEL66P1WQw
@export var max_spring_length: float = 1.0

@export var spring_stiffness: float = 1.0
@export var spring_damping: float = 0.01



func _ready():
	# https://en.wikipedia.org/wiki/Weight#Gravitational_definition
	var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	var weight: float = mass * gravity
	print('gravity ', gravity)
	print('mass ', mass)
	wheel_fl.init_suspension(weight / 4, max_spring_length, spring_stiffness, spring_damping)
	wheel_fr.init_suspension(weight / 4, max_spring_length, spring_stiffness, spring_damping)
	wheel_bl.init_suspension(weight / 4, max_spring_length, spring_stiffness, spring_damping)
	wheel_br.init_suspension(weight / 4, max_spring_length, spring_stiffness, spring_damping)

func _physics_process(delta: float) -> void:
	var vehicle_rotation = Quaternion(transform.basis)
	wheel_fl.apply_spring_force(delta, self, vehicle_rotation)
	wheel_fr.apply_spring_force(delta, self, vehicle_rotation)
	wheel_bl.apply_spring_force(delta, self, vehicle_rotation)
	wheel_br.apply_spring_force(delta, self, vehicle_rotation)
	pass
