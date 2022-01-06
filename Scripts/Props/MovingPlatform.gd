extends Node2D

onready var switch = $Switch
onready var sprite: Sprite = $Kinematic/Icon
onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if not switch.is_activate:
		anim_player.stop(false)
		sprite.material.set_shader_param("emission_amount", 0)
	else:
		anim_player.play("Moving")

func _on_Switch_on() -> void:
	anim_player.play("Moving")


func _on_Switch_off() -> void:
	anim_player.stop(false)
	sprite.material.set_shader_param("emission_amount", 0)
