extends PlayerState

export var animation_speed: float = 1

#Dash State
func enter(_msg: = {}):
	player.handle_animation(self.name, animation_speed)
	player.dash()
	player.dash_sound.play()
	ghost_coroutines()

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if player.dead:
		player.trail.visible = false
		state_machine.transition_to("Dead")

func exit() -> void:
	player.set_gravity(player.GRAVITY)
	
func ghost_coroutines():
	spawn_ghost()
	yield(get_tree().create_timer(0.05), "timeout")
	spawn_ghost()
	yield(get_tree().create_timer(0.05), "timeout")
	spawn_ghost()
	yield(get_tree().create_timer(0.05), "timeout")
	spawn_ghost()
	
func spawn_ghost():
	if not player.dead:
		var ghost = player.ghost_sprite.instance()
		ghost.global_position = player.global_position
		ghost.flip_h = not player.lookingRight
		get_parent().get_parent().get_parent().add_child(ghost)

func _on_DashTimer_timeout():
	player.trail.visible = false
	state_machine.transition_to("Idle")
