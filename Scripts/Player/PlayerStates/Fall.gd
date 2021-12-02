extends PlayerState

var last_state: String = ""

export var animation_speed: float = 1.5
export var prefall_animation_speed: float = 3

# Fall State
func enter(_msg: = {}):
	last_state = _msg["last_state"]
	handle_init_anim()
	player.set_gravity(player.FALL_GRAVITY)
#	print(self.name)

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.move()
	
	if player.dead:
		state_machine.transition_to("Dead")
	else:
		if last_state == "Jump":
			if player.jump_timer.time_left > 0 and player.jumps_left > 0:
				state_machine.transition_to("Jump")
		else:
			if player.jump_timer.time_left > 0 and player.jumps_left > 0 and player.was_grounded:
				state_machine.transition_to("Jump")
		
		if player.is_on_floor():
			state_machine.transition_to("Land")
		
		if Input.is_action_just_pressed("ui_dash") and player.can_dash():
			state_machine.transition_to("Dash")

func exit() -> void:
	player.set_gravity(player.GRAVITY)

func handle_init_anim():
	if last_state == "Jump":
		player.handle_animation("PreFall", prefall_animation_speed)
	else:
		player.handle_animation(self.name, animation_speed)

func _on_AnimatedSprite_animation_finished():
	if player.anim_player.animation == "PreFall":
		player.handle_animation(self.name)
