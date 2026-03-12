extends Node2D

@onready var notes_container: Node = $"../Notes"
@export var note_scene: PackedScene
@export var lead_beats: float = 8.0

var chart: Array[float] = [2.0, 4.0, 6.0, 8.0]
var next_index: int = 0

func _process(_delta: float) -> void:
	if note_scene == null:
		push_error("NoteSpawner: note_scene is not assigned!")
		return

	var current_beat: float = float(Conductor.song_position_in_beats)

	while next_index < chart.size() and (chart[next_index] - current_beat) <= lead_beats:
		var beat: float = chart[next_index]

		var note: Node = note_scene.instantiate()
		note.set("note_beat", beat)
		notes_container.add_child(note)

		next_index += 1
