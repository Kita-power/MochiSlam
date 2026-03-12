extends Node2D

var note_beat = 0
var speed = 100
var hit_x = 66
var lane_y = 324

func _ready():
	position.y = lane_y

func _process(delta):

	var beat_diff = note_beat - Conductor.song_position_in_beats

	position.x = hit_x + beat_diff * speed
