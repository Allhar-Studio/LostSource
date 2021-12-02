extends Node

var is_paused = false setget set_is_paused

var checkpoint = {
	"is_active": false,
	"position": Vector2.ZERO,
	"name": ""
}

func _ready():
	pass
	
func restart():
	var _reload_scene = get_tree().reload_current_scene()
	
func set_is_paused(value: bool):
	is_paused = value
	get_tree().paused = is_paused

func change_level():
	_reset_checkpoint()
	var level_count = Levels.levels.size()
	var current_scene = get_tree().get_current_scene().get_name()
	var current_level = current_scene.trim_prefix("Level-")
	if int(current_level) == level_count - 1:
		var _new_scene = get_tree().change_scene_to(Levels.cutscenes["PreEnd"])
	elif int(current_level) < level_count - 1:
		var next_level = int(current_level) + 1
		var _new_scene = get_tree().change_scene_to(Levels.levels["Level-"+str(next_level)])
	else:
		AudioManager.stop_main_song()
		var _last_scene = get_tree().change_scene_to(Levels.cutscenes["LastScene"])

func _reset_checkpoint():
	checkpoint["is_active"] = false
	checkpoint["position"] = Vector2.ZERO
	checkpoint["name"] = ""
