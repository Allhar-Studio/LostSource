extends Node2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.in_deadly_ground = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.in_deadly_ground = false
