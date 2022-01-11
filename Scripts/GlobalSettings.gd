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

signal brigthness_updated()

func _ready():
	pass

func update_brightness(value: float) -> void:
	video["brightness"] = value
	emit_signal("brigthness_updated")
