extends Resource
class_name Configuration

@export var selected_map : PackedScene
@export var selected_vehicle : SelectableVehicle

@export var available_maps : Array[PackedScene]
@export var available_vehicles: Array[SelectableVehicle]

func get_available_vehicles():
	return available_vehicles
