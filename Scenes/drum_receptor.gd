extends Node2D

@onready var left_rim: Sprite2D = $MochiNoteReceptorLeftRim
@onready var right_rim: Sprite2D = $MochiNoteReceptorRightRim
@onready var left_centre: Sprite2D = $MochiNoteReceptorLeftDrum
@onready var right_centre: Sprite2D = $MochiNoteReceptorRightDrum


func _ready() -> void:
	_set_sprite_visible(left_rim, false)
	_set_sprite_visible(right_rim, false)
	_set_sprite_visible(left_centre, false)
	_set_sprite_visible(right_centre, false)

func _set_sprite_visible(sprite: Sprite2D, is_visible: bool) -> void:
	sprite.visible = is_visible
	
func set_hit_visible(hit_name: String, is_visible: bool) -> void:
	match hit_name:
		"left_rim":
			_set_sprite_visible(left_rim, is_visible)
		"left_drum":
			_set_sprite_visible(left_centre, is_visible)
		"right_drum":
			_set_sprite_visible(right_centre, is_visible)
		"right_rim":
			_set_sprite_visible(right_rim, is_visible)
