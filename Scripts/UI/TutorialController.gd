extends Node

onready var ui = get_parent().get_node("UI")

func _on_JumpTutoArea_body_entered(body) -> void:
	if body.name == "Player":
		ui.get_node("JumpTutorial").visible = true

func _on_JumpTutoArea_body_exited(body) -> void:
	if body.name == "Player":
		ui.get_node("JumpTutorial").visible = false


func _on_DoubleJumpArea_body_entered(body) -> void:
	if body.name == "Player":
		ui.get_node("DoubleJumpTutorial").visible = true


func _on_DoubleJumpArea_body_exited(body) -> void:
	if body.name == "Player":
		ui.get_node("DoubleJumpTutorial").visible = false

func _on_DashArea_body_entered(body) -> void:
	if body.name == "Player":
		ui.get_node("Dash").visible = true

func _on_DashArea_body_exited(body) -> void:
	if body.name == "Player":
		ui.get_node("Dash").visible = false

func _on_HoldJumpArea_body_entered(body) -> void:
	if body.name == "Player":
		ui.get_node("HoldJump").visible = true

func _on_HoldJumpArea_body_exited(body) -> void:
	if body.name == "Player":
		ui.get_node("HoldJump").visible = false

func _on_SwitchArea_body_entered(body) -> void:
	if body.name == "Player":
		ui.get_node("Switch").visible = true

func _on_SwitchArea_body_exited(body) -> void:
	if body.name == "Player":
		ui.get_node("Switch").visible = false
