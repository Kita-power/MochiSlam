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
		$Lane/DrumReceptor.set_hit_visible("left_rim", true)
		_try_hit(Note.NoteType.RIM)

	if Input.is_action_just_released("hit_rim_left"):
		$Lane/DrumReceptor.set_hit_visible("left_rim", false)


	if Input.is_action_just_pressed("hit_centre_left"):
		$Lane/DrumReceptor.set_hit_visible("left_drum", true)
		_try_hit(Note.NoteType.CENTER)

	if Input.is_action_just_released("hit_centre_left"):
		$Lane/DrumReceptor.set_hit_visible("left_drum", false)


	if Input.is_action_just_pressed("hit_centre_right"):
		$Lane/DrumReceptor.set_hit_visible("right_drum", true)
		_try_hit(Note.NoteType.CENTER)

	if Input.is_action_just_released("hit_centre_right"):
		$Lane/DrumReceptor.set_hit_visible("right_drum", false)


	if Input.is_action_just_pressed("hit_rim_right"):
		$Lane/DrumReceptor.set_hit_visible("right_rim", true)
		_try_hit(Note.NoteType.RIM)

	if Input.is_action_just_released("hit_rim_right"):
		$Lane/DrumReceptor.set_hit_visible("right_rim", false)
		
	_check_for_missed_notes()

func _try_hit(expected_type: int) -> void:
	var current_beat: float = float(Conductor.song_position_in_beats)

	var best_note: Note = null
	var best_error: float = INF

	for child in notes_container.get_children():
		if child is Note:
			var note := child as Note
			var err: float = abs(note.note_beat - current_beat) #might double check this

			if err < best_error:
				best_error = err
				best_note = note

	# Ghost tap: no note exists nearby.
	if best_note == null:
		return

	# Ghost tap: the press is too early or too late.
	if best_error > good_window_beats:
		return

	# The player hit the wrong drum type.
	if best_note.note_type != expected_type:
		print("MISS (wrong type)")
		best_note.queue_free()
		return

	if best_error <= perfect_window_beats:
		print("PERFECT")
	else:
		print("GOOD")

	best_note.queue_free()
	
func _check_for_missed_notes() -> void:
	var current_beat: float = float(Conductor.song_position_in_beats)

	for child in notes_container.get_children():
		if child is Note:
			var note := child as Note

			# The note has passed the valid hit window.
			if current_beat - note.note_beat > good_window_beats:
				print("MISS (not hit)")
				note.queue_free()
