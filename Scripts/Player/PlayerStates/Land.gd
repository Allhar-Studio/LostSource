extends PlayerState

export var animation_speed: float = 1

#Land State
func enter(_msg: = {}):
	player.handle_animation(self.name, animation_speed)
	player.hit_the_floor()
	player.land_sound.play()
	player.emit_jump_particle()

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.move()
	
	if player.dead:
		state_machine.transition_to("Dead")
	else:
		if player.jump_timer.time_left > 0:
			state_machine.transition_to("Jump")
		
		if Input.is_action_just_pressed("ui_dash") and player.can_dash():
			state_machine.transition_to("Dash")

func exit() -> void:
	pass

func _on_AnimatedSprite_animation_finished():
	if player.anim_player.animation == self.name:
		if player.movement == 0 or not player.can_move:
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")
