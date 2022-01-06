extends Node

onready var ui = {
	"Main": preload("res://Scenes/UI/MainMenu.tscn"),
	"Credits": preload("res://Scenes/UI/Credits.tscn"),
	"Settings": preload("res://Scenes/UI/Config.tscn")
}

onready var cutscenes = {
	"Intro": preload("res://Scenes/CutScenes/Intro.tscn"),
	"LastScene": preload("res://Scenes/CutScenes/LastScene.tscn"),
	"PreEnd": preload("res://Scenes/CutScenes/PreEnd.tscn")
}

onready var levels = {
	"Level-1": preload("res://Scenes/Levels/Level-1.tscn"),
	"Level-2": preload("res://Scenes/Levels/Level-2.tscn"),
	"Level-3": preload("res://Scenes/Levels/Level-3.tscn"),
	"Level-4": preload("res://Scenes/Levels/Level-4.tscn"),
	"Level-5": preload("res://Scenes/Levels/Level-5.tscn"),
	"Level-6": preload("res://Scenes/Levels/Level-6.tscn"),
	"Level-7": preload("res://Scenes/Levels/Level-7.tscn"),
	"Level-8": preload("res://Scenes/Levels/Level-8.tscn")
}
