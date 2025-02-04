extends Control
class_name MainMenuRootNode

var INITIAL_CONFIG = preload("res://assets/resources/initial_config.tres")
@onready var init_control: Control = $InitControl
@onready var level_select_control: Control = $LevelSelectControl
@onready var vehicle_select_control: Control = $VehicleSelectControl

func get_config():
	print("returning config", INITIAL_CONFIG)
	return INITIAL_CONFIG

@onready var MainMenuStates = {
	"init": {
		"current": true,
		"controls": init_control
	},
	"vehicle_select": {
		"current": false,
		"controls": vehicle_select_control
	},
	"level_select": {
		"current": false,
		"controls": level_select_control
	},
}

var current_menu_state = "init"


func switch_to_new_menu_state(menu_state: String) -> void:
	MainMenuStates[current_menu_state].controls.visible = false
	
	var controls = MainMenuStates[menu_state].controls
	controls.visible = true
	
	current_menu_state = menu_state
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch_to_new_menu_state(current_menu_state)
	pass # Replace with function body.
