extends Node3D
class_name MainLevelLoading

var init_config : Configuration

var selected_vehicle : SelectableVehicle

@onready var spawn_point: Node3D = $SpawnPoint


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_config = ResourceLoader.load("user://main_menu_config.tres")
	
	# add selected vehicle to scene tree
	var selected_vehicle = init_config.selected_vehicle.vehicle_scene.instantiate()
	add_child(selected_vehicle)
	
	# move it to the spawn point
	selected_vehicle.transform = spawn_point.transform
	pass # Replace with function body.
