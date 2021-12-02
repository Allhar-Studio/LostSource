extends Node

var amplitude := 0.0

onready var camera: Camera2D = get_parent()
onready var shake_tween: Tween = $ShakeTween
onready var frequency: Timer = $Frequency
onready var duration: Timer = $Duration


func shake(_duration: float = 0.2, _frequency: float = 15.0, _amplitude: float = 16.0):
	amplitude = _amplitude
	duration.wait_time = _duration
	frequency.wait_time = 1 / _frequency
	duration.start()
	frequency.start()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	var _tween_interpolate = shake_tween.interpolate_property(camera, "offset", camera.offset, rand, frequency.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	var _tween_start = shake_tween.start()


func _on_Duration_timeout():
	var _tween_interpolate = shake_tween.interpolate_property(camera, "offset", camera.offset, Vector2.ZERO, frequency.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	var _tween_start = shake_tween.start()


func _on_Frequency_timeout():
	_new_shake()
