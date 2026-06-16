class_name LevelData extends Resource
##this is to store any additional data the level loader might need while loading a scene

@export var name: String
@export var packed_scene: PackedScene

func _init(
	p_name = "",
	p_packed_scene = null
):
	name = p_name
	packed_scene = p_packed_scene
