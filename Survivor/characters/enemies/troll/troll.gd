class_name Troll extends Enemy

@onready var health = $ProgressBar


func _ready() -> void:
	super._ready()
	_speed = 25.0

func _on_target_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bullet"):
		health.value -= 20


func _on_progress_bar_value_changed(value: float) -> void:
	if value <= 0:
		queue_free()
