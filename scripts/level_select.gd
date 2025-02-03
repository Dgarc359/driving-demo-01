extends Button

@export var scene_to_switch_to: PackedScene

func _pressed():
	get_tree().change_scene_to_packed(scene_to_switch_to)
	pass
