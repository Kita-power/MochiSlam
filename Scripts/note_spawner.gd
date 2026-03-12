extends Node2D

@onready var notes_container: Node = $"../Notes"

@export var pink_scene: PackedScene
@export var yellow_scene: PackedScene
@export var lead_beats: float = 8.0

var chart := [
	{"beat": 10.0, "type": "pink"},
	{"beat": 12.0, "type": "yellow"},
	{"beat": 14.0, "type": "yellow"},
]

var next_index: int = 0

func _process(_delta: float) -> void:
	var current_beat: float = float(Conductor.song_position_in_beats)

	while next_index < chart.size() and (float(chart[next_index]["beat"]) - current_beat) <= lead_beats:
		var entry: Dictionary = chart[next_index]
		var beat: float = float(entry["beat"])
		var t: String = String(entry["type"])

		var scene: PackedScene = pink_scene if t == "pink" else yellow_scene
		var note: Node = scene.instantiate()
		note.set("note_beat", beat)

		notes_container.add_child(note)
		next_index += 1
