extends Area2D

onready var slash_sound: AudioStreamPlayer2D = $SlashSound

func _on_Saw_body_entered(body) -> void:
	if body.name == "Player":
		slash_sound.play()
		body.die()
