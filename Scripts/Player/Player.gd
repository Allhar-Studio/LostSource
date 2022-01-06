class_name Player
extends KinematicBody2D

export var SPEED := 250
export var DASH_SPEED := 500
export var GRAVITY := 1500
export var FALL_GRAVITY := 3000
export var JUMP_TIME := 0.1
export var dash_time := 0.2
export var dash_cooldown_time := 0.5
export var coyot_time := 0.07
export var max_jumps := 2
export var max_energy := 100.0
export var energy_decrease_multiplier := 2.0
export var dash_energy_cost := 20
export var deadly_ground_energy_cost := 10
export var switch_energy_cost := 5
export var normal_energy_color: Color
export var use_energy_color: Color

var velocity := Vector2.ZERO
var movement := 0.0
var gravity := 0.0
var jumps_left := 2
var energy := 100.0

var lookingRight := true
var is_jumping := false
var was_grounded := false
var is_coyot_run := false
var is_jump_timer_runing := false
var dash_cooldown := false
var in_deadly_ground := false
var is_overloaded := false

onready var start_timer: Timer = $StartTimer
onready var jump_timer: Timer = $JumpTimer
onready var coyot_timer: Timer = $CoyotTimer
onready var dash_timer: Timer = $DashTimer
onready var dash_cooldown_timer: Timer = $DashCooldownTimer
onready var energy_timer: Timer = $EnergyTimer
onready var deadly_ground_timer: Timer = $DeadlyGroundTimer
onready var use_energy_timer: Timer = $UseEnergyTimer
onready var overload_timer: Timer = $OverloadTimer
onready var anim_player: AnimatedSprite = $AnimatedSprite
onready var anim_player_tube: AnimatedSprite = $AnimatedSprite2
onready var animations: AnimationPlayer = $AnimationPlayer
onready var energy_particles: Particles2D = $UseEnergyParticles
onready var walk_particles: Particles2D = $WalkParticles
onready var land_particles: Particles2D = $LandParticles
onready var walk_particles2: Particles2D = $WalkParticles2
onready var land_particles2: Particles2D = $LandParticles2
onready var emission_maps: Node = $EmissionMaps
onready var trail = $Trail2D

onready var dash_sound: AudioStreamPlayer2D = $DashSound
onready var die_sound: AudioStreamPlayer2D = $DeadSound
onready var jump_sound: AudioStreamPlayer2D = $JumpSound
onready var land_sound: AudioStreamPlayer2D = $LandSound
onready var deadly_ground_sound: AudioStreamPlayer2D = $DeadlyGroundSound
onready var walk_sound: AudioStreamPlayer2D = $WalkSound

onready var ghost_sprite = preload("res://Scenes/Objects/PlayerGhost.tscn")

var jump_input: bool
var walk_right: float
var walk_left: float
var dead: bool = false
var can_move: bool = false
var is_over_checkpoint: bool = false
var is_changing_level: bool = false

signal dead
signal dash
signal use_energy

func _ready() -> void:
	gravity = GRAVITY
	jumps_left = max_jumps
	energy = max_energy
	_handle_start_pos()
	start_timer.start()
	is_changing_level = false
	
func _physics_process(delta) -> void:
	walk_right = Input.get_action_strength("ui_right")
	walk_left = Input.get_action_strength("ui_left")
	jump_input = Input.is_action_pressed("ui_jump")
	
	movement = walk_right - walk_left
	
	if _check_if_should_flip(walk_right, walk_left) and can_move:
		_flip()
		
	jump(JUMP_TIME)
	
	_keep_decrease_energy(delta)
	_check_in_deadly_ground()
	_handle_secondary_texture()
	_handle_walk_sound()

	if not is_on_floor() and not is_coyot_run:
		is_coyot_run = true
		coyot_timer.start(coyot_time)
		
	if energy <= 0 and not dead:
		die()
	
	if Input.is_action_just_pressed("ui_overload") and not is_overloaded:
		is_overloaded = true
		overload_timer.start()
	
	velocity.y += gravity * delta
	
	var snap = Vector2.DOWN * 32 if not is_jumping else Vector2.ZERO

	velocity = move_and_slide_with_snap(velocity, snap, Vector2(0, -1))

func _check_if_should_flip(right: float, left: float) -> bool:
	return (lookingRight and left and not right) or (not lookingRight and right and not left)

func _flip() -> void:
	lookingRight = not lookingRight
	scale.x *= -1

func handle_animation(name: String, _speed: float = 1.0, _loop = true) -> void:
	anim_player.play(name)
	anim_player.speed_scale = _speed
	anim_player.material.set_shader_param("emission_texture", emission_maps.emission_maps[name])

func move() -> void:
	if can_move:
		velocity.x = movement * SPEED

func jump(duration: float) -> void:
	if Input.is_action_just_pressed("ui_jump"):
		jump_timer.start(duration)
		is_jump_timer_runing = true

func start_dash_timer() -> void:
	dash_timer.start(dash_time)
	dash_cooldown_timer.start(dash_cooldown_time)

func set_velocity_x(speed: float) -> void:
	velocity.x = speed

func set_velocity_y(speed: float) -> void:
	velocity.y = speed
	
func set_gravity(gravity_value: float) -> void:
	gravity = gravity_value

func hit_the_floor() -> void:
	is_jumping = false
	is_coyot_run = false
	was_grounded = true
	coyot_timer.stop()
	jumps_left = max_jumps
	
func _keep_decrease_energy(_delta: float) -> void:
	if not dead and not is_over_checkpoint and not is_overloaded:
		energy -= energy_decrease_multiplier * _delta
		energy = clamp(energy, 0, max_energy)
	
func decrease_energy(_amount: float) -> void:
	if can_move and not is_overloaded:
		energy -= _amount
		emit_signal("use_energy")
		anim_player.material.set_shader_param("glow_color", use_energy_color)
		anim_player_tube.material.set_shader_param("burn_color", use_energy_color)
		energy_particles.emitting = true
		use_energy_timer.start()

func increase_energy(amount: float) -> void:
	energy += amount
	is_overloaded = false

func recover_energy() -> void:
	energy = max_energy
	is_overloaded = false

func over_checkpoint() -> void:
	is_over_checkpoint = true
	recover_energy()

func out_checkpoint() -> void:
	is_over_checkpoint = false

func transition() -> void:
	can_move = false
	is_changing_level = true

func dash() -> void:
	dash_cooldown = true
	var direction = 1 if lookingRight else -1
	set_gravity(0)
	set_velocity_y(0)
	set_velocity_x(DASH_SPEED * direction)
	start_dash_timer()
	emit_signal("dash")
	trail.visible = true
	decrease_energy(dash_energy_cost)

func can_dash() -> bool:
	return (energy >= dash_energy_cost and not dash_cooldown) or (not dash_cooldown and is_overloaded)

func die() -> void:
	if not is_changing_level:
		dead = true
		can_move = false
		anim_player_tube.visible = false
		emit_signal("dead")

func _check_in_deadly_ground() -> void:
	if in_deadly_ground and deadly_ground_timer.is_stopped():
		deadly_ground_sound.play()
		decrease_energy(deadly_ground_energy_cost)
		deadly_ground_timer.start()
	elif not in_deadly_ground:
		deadly_ground_timer.stop()
		deadly_ground_sound.stop()
	if dead:
		deadly_ground_sound.stop()
		
func _handle_secondary_texture() -> void:
	if anim_player_tube.animation != anim_player.animation:
		anim_player_tube.animation = anim_player.animation
	anim_player_tube.frame = anim_player.frame

	anim_player_tube.material.set_shader_param("burn_size", energy / 400)
	anim_player_tube.material.set_shader_param("emission_amount", energy / 20)
	anim_player.material.set_shader_param("emission_amount", energy / 10)

	anim_player_tube.scale = anim_player.scale
	
func _handle_walk_sound() -> void:
	if anim_player.animation == "Walk" and (anim_player.frame == 8 or anim_player.frame == 26):
		walk_sound.pitch_scale = rand_range(0.8, 1)
		walk_sound.play()
		emit_walk_particles()

func emit_walk_particles() -> void:
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Ground":
			walk_particles.emitting = true
		else:
			walk_particles2.emitting = true

func emit_jump_particle() -> void:
	if not is_on_floor():
		land_particles2.emitting = true
	else:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.name == "Ground":
				land_particles.emitting = true
			else:
				land_particles2.emitting = true

func handle_switch(using_energy: bool) -> void:
	if using_energy:
		decrease_energy(switch_energy_cost)
	else:
		increase_energy(switch_energy_cost)

func _handle_start_pos() -> void:
	if GameManager.checkpoint["is_active"] == true:
		var start_pos = GameManager.checkpoint["position"]
		position = start_pos

func _on_CoyotTimer_timeout() -> void:
	was_grounded = false
	
func _on_DashCooldownTimer_timeout() -> void:
	dash_cooldown = false

func _on_StartTimer_timeout() -> void:
	can_move = true

func _on_DeadlyGroundTimer_timeout() -> void:
	decrease_energy(deadly_ground_energy_cost)

func _on_UseEnergyTimer_timeout() -> void:
	anim_player.material.set_shader_param("glow_color", normal_energy_color)
	anim_player_tube.material.set_shader_param("burn_color", normal_energy_color)

func _on_JumpTimer_timeout() -> void:
	is_jump_timer_runing = false

func _on_OverloadTimer_timeout():
	if is_overloaded:
		is_overloaded = false
		decrease_energy(100)
