extends Node

var bpm = 172.81
var seconds_per_beat
var song_position = 0.0
var song_position_in_beats = 0.0

var music_player: AudioStreamPlayer

func _ready():
	seconds_per_beat = 60.0 / bpm

func _process(delta):
	if music_player:
		song_position = music_player.get_playback_position()
		song_position_in_beats = song_position / seconds_per_beat
