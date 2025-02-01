extends Control


@onready var car_controller: CustomCarController = $".."
@onready var mph_text_box: TextEdit = $MPH


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mph_text_box.text = "current mph: %s" % car_controller.get_current_speed()
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mph_text_box.text = "current mph: %s" % car_controller.get_current_speed()
	pass
