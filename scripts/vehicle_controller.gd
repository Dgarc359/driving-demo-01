extends Control
@onready var menu_ui: MainMenuRootNode = $".."

var initial_config: Configuration

func on_vehicle_selected():
	#print(self)
	#print('button pressed')
	menu_ui.switch_to_new_menu_state("level_select")

func _ready() -> void:
	initial_config =  menu_ui.get_config()
	
	var vbox = VBoxContainer.new()
	add_child(vbox)
	
	# TODO: center vbox
	
	for available_vehicle in initial_config.available_vehicles:
		var button = SelectableVehicleButton.new()
		button.set_text(available_vehicle.display_name)
		button.selectable_vehicle = available_vehicle
		#button.selectable_node = available_vehicle
		button.pressed.connect(on_vehicle_selected)
		vbox.add_child(button)
	
