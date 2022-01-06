class_name AbilityState
extends PlayerState

var is_ability_done: bool = false

# Ability State
func enter(_msg: = {}) -> void:
	.enter(_msg)
	
	is_ability_done = false
	
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if player.dead:
		state_machine.transition_to("Dead")
	elif is_ability_done:
		state_machine.transition_to("Idle")

func exit() -> void:
	.exit()
	
