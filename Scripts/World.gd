extends Node

onready var env: WorldEnvironment = $WorldEnvironment

func _ready() -> void:
	var _use_energy_signal = $Player.connect("use_energy", $UI, "_on_Player_use_energy")
	var _dead_signal = $Player.connect("dead", $FadeEffect, "_on_Player_dead")
	var _transition_signal = $ChangeLevel.connect("change", $FadeEffect, "_on_ChangeLevel_change")
	var _fade_finished_signal = $FadeEffect/FadeAnimationPlayer.connect("animation_finished", $ChangeLevel, "_on_FadeAnimationPlayer_animation_finished")
	var _dash_signal = $Player.connect("dash", $Camera2D, "_on_Player_dash")
	var _brightness_connect = GlobalSettings.connect("brigthness_updated", self, "_update_btightness")

func _update_btightness() -> void:
	env.environment.adjustment_brightness = GlobalSettings.video["brightness"]
