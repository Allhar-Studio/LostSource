extends Control

onready var anim: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		var _next_scene = get_tree().change_scene_to(Levels.ui["Credits"])
	if Input.is_action_just_pressed("ui_jump"):
		_handle_animation(anim.current_animation)

func _handle_animation(name: String):
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
			var _next_scene = get_tree().change_scene_to(Levels.ui["Credits"])

func _on_AnimationPlayer_animation_finished(anim_name):
	_handle_animation(anim_name)
