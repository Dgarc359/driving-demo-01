extends Button


@onready var menu_ui: MainMenuRootNode = $"../.."

func _pressed():
	menu_ui.switch_to_new_menu_state("vehicle_select")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
