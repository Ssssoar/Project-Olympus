extends Node

@export var scene_library: Array[LevelData]
var current_level_data: LevelData
var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(-1)
	current_level_data = find_level_data((current_scene as Level).level_name)
	if current_level_data == null:
		printerr("[LEVEL LOADER]: Current level's name " + (current_scene as Level).level_name + " doesn't match any level in the scene library")

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("TEST_RESET")):
		reload_scene()

func reload_scene():
	load_level_data.call_deferred(current_level_data)

func load_scene_by_name(scene_name: String):
	var level_data = find_level_data(scene_name)
	load_level_data.call_deferred(level_data)

func find_level_data(scene_name) -> LevelData:
	for level_data in scene_library:
		if level_data.name == scene_name:
			return level_data
	return null

func load_level_data(level_data: LevelData):
	current_scene.free()
	current_scene = level_data.packed_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
