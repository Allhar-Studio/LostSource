extends Control

onready var anim: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		AudioManager.play_main_song()
		var _next_scene = get_tree().change_scene_to(Levels.levels["Level-1"])
	if Input.is_action_just_pressed("ui_jump"):
		_handle_animation(anim.current_animation)

func _handle_animation(name: String) -> void:
	match name:
		"First":
			anim.play("Second")
		"Second":
			anim.play("Third")
		"Third":
			anim.play("Fourth")
		"Fourth":
			anim.play("Fifth")
		"Fifth":
			AudioManager.play_main_song()
			var _next_scene = get_tree().change_scene_to(Levels.levels["Level-1"])

func _on_AnimationPlayer_animation_finished(anim_name) -> void:
	_handle_animation(anim_name)
