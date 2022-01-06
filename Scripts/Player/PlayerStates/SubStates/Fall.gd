extends AirState

var last_state: String = ""

export var animation_speed: float = 1.5
export var prefall_animation_speed: float = 3

# Fall State
func enter(_msg: = {}) -> void:
	.enter(_msg)
	last_state = _msg["last_state"]
	handle_init_anim()
	player.set_gravity(player.FALL_GRAVITY)

func physics_update(_delta: float) -> void:
	.physics_update(_delta)
	
	if not is_exiting_state:
		player.move()
		
	if last_state == "Jump":
		if player.is_jump_timer_runing and player.jumps_left > 0:
			state_machine.transition_to("Jump")
	else:
		if player.is_jump_timer_runing and player.jumps_left > 0 and player.was_grounded:
			state_machine.transition_to("Jump")
	
	if player.is_on_floor():
		state_machine.transition_to("Land")

func exit() -> void:
	.exit()
	player.set_gravity(player.GRAVITY)

func handle_init_anim() -> void:
	if last_state == "Jump":
		player.handle_animation("PreFall", prefall_animation_speed)
	else:
		player.handle_animation(self.name, animation_speed)

func _on_AnimatedSprite_animation_finished() -> void:
	if player.anim_player.animation == "PreFall":
		player.handle_animation(self.name)
