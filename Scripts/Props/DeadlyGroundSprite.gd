extends Node2D

onready var sprite: Sprite = $Sprite

func _on_Area2D_body_entered(body) -> void:
	if body.name == "Player":
		sprite.material.set_shader_param("emission_amount", 3)


func _on_Area2D_body_exited(body) -> void:
	if body.name == "Player":
		sprite.material.set_shader_param("emission_amount", 0)
