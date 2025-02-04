extends Button
class_name SelectableVehicleButton

@onready var menu_ui: MainMenuRootNode = $"."

@export var selectable_vehicle : SelectableVehicle

func _pressed() -> void:
	menu_ui.INITIAL_CONFIG.selected_vehicle = selectable_vehicle
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
