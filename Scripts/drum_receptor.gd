extends Node2D

@onready var left_rim: Sprite2D = $LeftRim
@onready var left_centre: Sprite2D = $LeftCentre
@onready var right_centre: Sprite2D = $RightCentre
@onready var right_rim: Sprite2D = $RightRim

var original_scales: Dictionary = {}

func _ready() -> void:
	original_scales[left_rim] = left_rim.scale
	original_scales[left_centre] = left_centre.scale
	original_scales[right_centre] = right_centre.scale
	original_scales[right_rim] = right_rim.scale

	# Keep the hit overlays invisible until their corresponding key is pressed.
	left_rim.modulate.a = 0.0
	left_centre.modulate.a = 0.0
	right_centre.modulate.a = 0.0
	right_rim.modulate.a = 0.0

func play_hit_animation(hit_name: String) -> void:
	var sprite: Sprite2D

	match hit_name:
		"left_rim":
			sprite = left_rim
		"left_centre":
			sprite = left_centre
		"right_centre":
			sprite = right_centre
		"right_rim":
			sprite = right_rim
		_:
			return

	var original_scale: Vector2 = original_scales[sprite]
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)

	# Restart cleanly if the same drum part is hit again quickly.
	tween.tween_property(sprite, "modulate:a", 1.0, 0.02)
	tween.parallel().tween_property(sprite, "scale", original_scale * 1.12, 0.02)
	tween.tween_property(sprite, "modulate:a", 0.0, 0.12)
	tween.parallel().tween_property(sprite, "scale", original_scale, 0.12)
