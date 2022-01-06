extends Node2D

onready var _area: Area2D = $Area2D
onready var collected_sound: AudioStreamPlayer2D = $CollectedSound
onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	var _area_connect = _area.connect("body_entered", self, "_on_Area2D_body_entered")
	
func _on_Area2D_body_entered(body) -> void:
	if body.name == "Player":
		body.recover_energy()
		collected_sound.play()
		anim.play("Collected")
