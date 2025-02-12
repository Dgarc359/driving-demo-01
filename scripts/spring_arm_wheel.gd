extends SpringArm3D
@onready var rigid_body_3d: RigidBody3D = $RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_excluded_object(rigid_body_3d.get_rid())
	
	pass # Replace with function body.
