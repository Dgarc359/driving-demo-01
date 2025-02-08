extends RigidBody3D
class_name RigidCar

# current raycast position is (0, -0.2, 0) METERS


# what units are these??
#@export var suspension_full_length: float = 0.5
#@export var spring_strength: float = 20.0
#@export var spring_damper: float = 1.0
#@export var wheel_radius: float = 0.33

@onready var wheel_br: WheelController = $WheelBR
@onready var wheel_fr: WheelController = $WheelFR
@onready var wheel_bl: WheelController = $WheelBL
@onready var wheel_fl: WheelController = $WheelFL


# reference for these vars: https://www.youtube.com/watch?v=6hEL66P1WQw
@export var spring_distance_max: float = -0.2
#@export var spring_constant: float = 42214.0 # ????? Reference is using magic numbers?????
#@export var spring_damping: float = 7904.0 # ????? 

@export var spring_constant: float = 40.0
@export var spring_damping: float = 0.001



func _ready():
	var weight: float = mass * ProjectSettings.get_setting("physics/3d/default_gravity")
	wheel_fl.init_suspension(weight / 4, spring_distance_max, spring_constant, spring_damping)
	wheel_fr.init_suspension(weight / 4, spring_distance_max, spring_constant, spring_damping)
	wheel_bl.init_suspension(weight / 4, spring_distance_max, spring_constant, spring_damping)
	wheel_br.init_suspension(weight / 4, spring_distance_max, spring_constant, spring_damping)

func _physics_process(delta: float) -> void:
	var vehicle_rotation = Quaternion(transform.basis)
	wheel_fl.apply_spring_force(delta, self, vehicle_rotation)
	wheel_fr.apply_spring_force(delta, self, vehicle_rotation)
	wheel_bl.apply_spring_force(delta, self, vehicle_rotation)
	wheel_br.apply_spring_force(delta, self, vehicle_rotation)
	pass
