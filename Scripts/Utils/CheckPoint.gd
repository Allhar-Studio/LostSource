extends Node2D

onready var sprite: Sprite = $Sprite
onready var light: Light2D = $Light2D

func _physics_process(_delta):
	if GameManager.checkpoint["name"] == self.name:
		sprite.material.set_shader_param("emission_amount", 1)
		light.visible = true
	else:
		sprite.material.set_shader_param("emission_amount", 0)
		light.visible = false

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.over_checkpoint()
		GameManager.checkpoint["is_active"] = true
		GameManager.checkpoint["position"] = Vector2(position.x, position.y - 64)
		GameManager.checkpoint["name"] = self.name


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.out_checkpoint()
