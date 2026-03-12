extends Node2D
@onready var notes_container: Node = $"../Notes"
@export var note_scene : PackedScene

var chart = [2, 4, 6, 8]

func _ready():
	if note_scene == null:
			push_error("NoteSpawner: note_scene is not assigned!")
			return
	for beat in chart:
		spawn_note(beat)
		
func spawn_note(beat):
	var note = note_scene.instantiate()
	note.note_beat = beat
	notes_container.add_child(note)
