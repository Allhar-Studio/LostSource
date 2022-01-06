class_name State
extends Node

var state_machine = null

var is_exiting_state: bool = false

func enter(_msg: = {}) -> void:
	#print(self.name)
	is_exiting_state = false
	
func update(_delta: float) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	is_exiting_state = true
