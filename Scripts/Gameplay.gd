extends Node2D

func _ready():
	Conductor.music_player = $Music
	$Music.play()
	print("Viewport size:", get_viewport().get_visible_rect().size)
