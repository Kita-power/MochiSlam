extends Node2D

func _ready():
	Conductor.music_player = $Music
	$Music.play()
