extends Node2D

var note_beat: float = 0.0

@export var hit_x: float = 66.0
@export var spawn_x: float = 1400.0
@export var lead_beats: float = 8.0
@export var lane_y: float = 324.0

func _ready() -> void:
	position.y = lane_y
	z_index = 100

func _process(_delta: float) -> void:
	var beats_until_hit: float = note_beat - float(Conductor.song_position_in_beats)
	var px_per_beat: float = (spawn_x - hit_x) / lead_beats
	position.x = hit_x + beats_until_hit * px_per_beat
