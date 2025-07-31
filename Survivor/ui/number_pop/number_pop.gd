class_name NumberPop extends Node2D
## Shows a number that fades away progressively


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label


func pop(value: String, color: Color = Color(1.0, 1.0, 1.0, 1.0), direction: String = "up") -> void:
		label.text = value
		label.add_theme_color_override("font_color", color)
		animation_player.play("fades_" + direction)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
