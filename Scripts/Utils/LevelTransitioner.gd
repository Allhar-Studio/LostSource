extends Node2D

onready var fade_anim: AnimationPlayer = get_parent().get_node("FadeEffect").get_node("AnimationPlayer")

onready var anim_timer: Timer = $Timer

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.transition()
		fade_anim.play("fade_in2")
		anim_timer.start()

func _on_Timer_timeout():
	GameManager.change_level()
