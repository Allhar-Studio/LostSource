extends Control

onready var anim: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		next_level()
	if Input.is_action_just_pressed("ui_jump"):
		next_level()

func next_level():
	var level_count = Levels.levels.size()
	var _next_scene = get_tree().change_scene_to(Levels.levels["Level-"+str(level_count)])


func _on_AnimationPlayer_animation_finished(_anim_name):
	next_level()
