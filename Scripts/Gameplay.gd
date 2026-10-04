extends Node2D
@onready var drum_receptor = $Lane/DrumReceptor
@onready var notes_container: Node = $Notes

@export var perfect_window_beats: float = 0.10
@export var good_window_beats: float = 0.20

func _ready() -> void:
	Conductor.music_player = $Music
	$Music.play()
	print("Viewport size:", get_viewport().get_visible_rect().size)

#Reminder that yellow is rim, pink is centre.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("hit_rim_left"):
		_try_hit(Note.NoteType.RIM)

	if Input.is_action_pressed("hit_rim_left"):
		$Lane/DrumReceptor.set_hit_visible("left_rim", true)

	if Input.is_action_just_released("hit_rim_left"):
		$Lane/DrumReceptor.set_hit_visible("left_rim", false)


	if Input.is_action_just_pressed("hit_centre_left"):
		_try_hit(Note.NoteType.CENTER)

	if Input.is_action_pressed("hit_centre_left"):
		$Lane/DrumReceptor.set_hit_visible("left_drum", true)

	if Input.is_action_just_released("hit_centre_left"):
		$Lane/DrumReceptor.set_hit_visible("left_drum", false)


	if Input.is_action_just_pressed("hit_centre_right"):
		_try_hit(Note.NoteType.CENTER)

	if Input.is_action_pressed("hit_centre_right"):
		$Lane/DrumReceptor.set_hit_visible("right_drum", true)

	if Input.is_action_just_released("hit_centre_right"):
		$Lane/DrumReceptor.set_hit_visible("right_drum", false)


	if Input.is_action_just_pressed("hit_rim_right"):
		_try_hit(Note.NoteType.RIM)

	if Input.is_action_pressed("hit_rim_right"):
		$Lane/DrumReceptor.set_hit_visible("right_rim", true)

	if Input.is_action_just_released("hit_rim_right"):
		$Lane/DrumReceptor.set_hit_visible("right_rim", false)

func _try_hit(expected_type: int) -> void:
	var current_beat: float = float(Conductor.song_position_in_beats)

	var best_note: Note = null
	var best_error: float = INF

	for child in notes_container.get_children():
		if child is Note:
			var note := child as Note

			# Optional: ignore notes that are way in the future
			# if note.note_beat - current_beat > 1.0:
			#     continue

			var err: float = abs(note.note_beat - current_beat)
			if err < best_error:
				best_error = err
				best_note = note

	if best_note == null:
		return

	# too early/late
	if best_error > good_window_beats:
		print("MISS (timing)")
		return

	# wrong color (center vs rim)
	if best_note.note_type != expected_type:
		print("MISS (wrong type)")
		return

	# judgement
	if best_error <= perfect_window_beats:
		print("PERFECT")
	else:
		print("GOOD")

	best_note.queue_free()
