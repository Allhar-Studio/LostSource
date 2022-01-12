extends Node

var volume = {
	"master": 1,
	"music": 1,
	"sfx": 1
}

var video = {
	"fullscreen": false,
	"vsync": true,
	"brightness": 1.0
}

var general = {
	"language": 0,
	"hint": true,
	"vibration": true
}

signal brigthness_updated()
signal disable_hint()

func _ready():
	pass

func disable_hint(value: bool) -> void:
	general["hint"] = value
	if value == false:
		emit_signal("disable_hint")

func update_brightness(value: float) -> void:
	video["brightness"] = value
	emit_signal("brigthness_updated")
