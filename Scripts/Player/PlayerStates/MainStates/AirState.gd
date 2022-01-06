class_name AirState
extends PlayerState

# Air State
func enter(_msg: = {}) -> void:
	.enter(_msg)
	
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if player.dead:
		state_machine.transition_to("Dead")
	else:
		if Input.is_action_just_pressed("ui_dash") and player.can_dash():
			state_machine.transition_to("Dash")

func exit() -> void:
	.exit()
	
