extends Control

onready var env: WorldEnvironment = $WorldEnvironment

func _ready():
	var _brightness_connect = GlobalSettings.connect("brigthness_updated", self, "_update_btightness")

func _update_btightness() -> void:
	env.environment.adjustment_brightness = GlobalSettings.video["brightness"]
