extends Node2D

signal change

func _on_FadeAnimationPlayer_animation_finished(anim_name) -> void:
	if anim_name == "fade_in":
		GameManager.restart()
	if anim_name == "fade_in2":
		GameManager.change_level()

func _on_Area2D_body_entered(body) -> void:
	if body.name == "Player":
		body.transition()
		emit_signal("change")
