# Contains the behavior common to all enemies
class_name Enemy extends Character

var _goal_position := Vector2()


func _ready() -> void:
	collision_layer = 0b0100 # collision layer 3, which is enemies
	collision_mask = 0b0011 # collision masks 1 and 2, which is environment and player
	PlayerManager.position_updated.connect(_on_player_position_updated)
	
	
func _physics_process(delta: float) -> void:
	if _can_move:
		# Moves towards the player
		var distance = _goal_position - global_position
		var direction = distance.normalized()
		velocity = direction * _speed
		var collision_info = move_and_collide(velocity * delta)

		
func _on_player_position_updated(player_position: Vector2) -> void:
	_goal_position = player_position
	
	
func _take_damage(raw_amount: float) -> void:
	var final_amount = raw_amount
	
	_health -= final_amount
	damage_taken.emit(final_amount)
	
	if _health <= 0:
		queue_free()
