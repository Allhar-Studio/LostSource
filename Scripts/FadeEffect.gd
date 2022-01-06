extends CanvasLayer

onready var anim: AnimationPlayer = $FadeAnimationPlayer

func _on_ChangeLevel_change() -> void:
	anim.play("fade_in2")

func _on_Player_dead() -> void:
	anim.play("fade_in")
