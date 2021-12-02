extends Node

onready var main_song: AudioStreamPlayer = $MainSong
onready var menu_song: AudioStreamPlayer = $MenuSong

func _physics_process(_delta):
	if get_tree().get_current_scene().get_name().begins_with("Level"):
		play_main_song()

func play_main_song():
	if not main_song.playing:
		main_song.play()

func stop_main_song():
	if main_song.playing:
		main_song.stop()

func play_menu_song():
	if not menu_song.playing:
		menu_song.play()

func stop_menu_song():
	if menu_song.playing:
		menu_song.stop()