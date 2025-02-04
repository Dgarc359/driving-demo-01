extends RayCast3D
class_name WheelRayCast

signal wheel_colliding



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	
	force_raycast_update()
	
	if is_colliding():
		wheel_colliding.emit()
		#print("collidingoregre")
	
	pass


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#force_
	#pass
