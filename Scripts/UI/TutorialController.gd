extends Node

var actived_tuto: String = ""

onready var ui = get_parent().get_node("UI")

func _ready() -> void:
	var _hint_connect = GlobalSettings.connect("disable_hint", self, "_disable_all")
	
func activate_hint(body_name: String, node_name: String) -> void:
	if body_name == "Player" and GlobalSettings.general["hint"] == true:
		ui.get_node(node_name).visible = true
		actived_tuto = node_name

func disable_hint(body_name: String, node_name: String) -> void:
	if body_name == "Player":
		ui.get_node(node_name).visible = false

func _disable_all() -> void:
	ui.get_node(actived_tuto).visible = false

func _on_JumpTutoArea_body_entered(body) -> void:
	activate_hint(body.name, "JumpTutorial")

func _on_JumpTutoArea_body_exited(body) -> void:
	disable_hint(body.name, "JumpTutorial")

func _on_DoubleJumpArea_body_entered(body) -> void:
	activate_hint(body.name, "DoubleJumpTutorial")

func _on_DoubleJumpArea_body_exited(body) -> void:
	disable_hint(body.name, "DoubleJumpTutorial")

func _on_DashArea_body_entered(body) -> void:
	activate_hint(body.name, "Dash")

func _on_DashArea_body_exited(body) -> void:
	disable_hint(body.name, "Dash")

func _on_HoldJumpArea_body_entered(body) -> void:
	activate_hint(body.name, "HoldJump")

func _on_HoldJumpArea_body_exited(body) -> void:
	disable_hint(body.name, "HoldJump")

func _on_SwitchArea_body_entered(body) -> void:
	activate_hint(body.name, "Switch")

func _on_SwitchArea_body_exited(body) -> void:
	disable_hint(body.name, "Switch")
