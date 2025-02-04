extends Control
@onready var menu_ui: MainMenuRootNode = $".."

var initial_config: Configuration

func on_vehicle_selected(vehicle):
	initial_config.selected_vehicle = vehicle
	ResourceSaver.save(initial_config, "user://main_menu_config.tres")
	menu_ui.switch_to_new_menu_state("level_select")

func _ready() -> void:
	initial_config =  menu_ui.get_config()
	
	var vbox = VBoxContainer.new()
	add_child(vbox)
	
	# TODO: center vbox
	
	for available_vehicle in initial_config.available_vehicles:
		var button = SelectableVehicleButton.new()
		button.set_text(available_vehicle.display_name)
		#button.selectable_vehicle = available_vehicle
		#button.selectable_node = available_vehicle
		button.pressed.connect(self.on_vehicle_selected.bind(available_vehicle))
		vbox.add_child(button)
	
