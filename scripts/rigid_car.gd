extends RigidBody3D

#@export var engine_force = 100.0
#@export var steering_torque = 50.0

func _physics_process(delta):
	# Apply engine force in the forward direction
	#if Input.is_action_pressed("ui_up"):
		#apply_central_force(-transform.basis.z * engine_force)
	#
	## Apply steering torque
	#if Input.is_action_pressed("ui_left"):
		#apply_torque(Vector3(0, steering_torque, 0))
		
		
	pass
