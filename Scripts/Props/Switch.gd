extends Node2D

signal on
signal off

var player_is_over := false
var player = null

export var is_activate := false

onready var sprite: Sprite = $Area2D/Sprite
onready var switch_sound: AudioStreamPlayer2D = $SwitchSound

func _ready():
	if is_activate:
		_change_sahder_param(true)
	else:
		_change_sahder_param(false)

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_activate") and player_is_over:
		_handle_switch()

func _handle_switch():
	switch_sound.play()
	
	if not is_activate:
		is_activate = true
		_change_sahder_param(true)
		emit_signal("on")
	else:
		is_activate = false
		_change_sahder_param(false)
		emit_signal("off")
	if player != null:
		player.handle_switch(is_activate)

func _change_sahder_param(active: bool):
	if active:
		sprite.material.set_shader_param("emission_amount", 3)
	else:
		sprite.material.set_shader_param("emission_amount", 0)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_is_over = true
		player = body

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_is_over = false
		player = null
