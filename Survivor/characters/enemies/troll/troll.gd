class_name Troll extends Enemy


func _ready() -> void:
	super._ready()


func _on_target_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bullet"):
		_take_damage(50)


func _on_progress_bar_value_changed(value: float) -> void:
	if value <= 0:
		queue_free()


func _on_target_area_area_entered(area: Area2D) -> void:
	if area.name == "HitArea":
		_take_damage(20)
	if area.name == "CrushArea":
		_take_damage(100)
