extends Node2D

func _on_Area2D_body_entered(body) -> void:
	if body.name == "Player":
		body.die()
