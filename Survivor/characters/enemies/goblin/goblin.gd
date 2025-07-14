class_name Ennemy extends CharacterBody2D

@onready var health = $ProgressBar


var _goal_position := Vector2()
var _can_move := true
var _speed := 50.0


func _ready() -> void:
	PlayerManager.position_updated.connect(_on_player_position_updated)


func _physics_process(delta: float) -> void:
	if _can_move:
		var direction = (_goal_position - global_position).normalized()
		velocity = direction * _speed
		var collision_info = move_and_collide(velocity * delta)


func _on_target_area_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("Bullet"):
		health.value -= 20


func _on_progress_bar_value_changed(value: float) -> void:
	if value <= 0:
		queue_free()
		
		
func _on_player_position_updated(player_position: Vector2) -> void:
	_goal_position = player_position
