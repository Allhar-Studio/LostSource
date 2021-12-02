extends Node

onready var emission_maps = {
	"Idle": preload("res://Player/Sprites/character/idle/idle-eye.png"),
	"Walk": preload("res://Player/Sprites/character/run/run-eye.png"),
	"Jump": preload("res://Player/Sprites/character/jump/jump-eye.png"),
	"PreJump":  preload("res://Player/Sprites/character/pre-jump/pre-jump-eye.png"),
	"PreFall":  preload("res://Player/Sprites/character/pre-fall/pre-fall-eye.png"),
	"Fall":  preload("res://Player/Sprites/character/fall/fall-eye.png"),
	"Land":  preload("res://Player/Sprites/character/Land/land-eye.png"),
	"Dash":  preload("res://Player/Sprites/character/dash/dash_eye.png"),
	"Dead":  preload("res://Player/Sprites/character/die/die-eye.png"),
	"NoEnergy":  preload("res://Player/Sprites/character/no-energy/no-energy-eye.png"),
}
