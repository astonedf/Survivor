extends Node2D

## Overriden by parent node speed if the parent has a speed or _speed property
@export var _speed := 0


var _to_move: CharacterBody2D
var _goal_position := Vector2()



func _ready() -> void:
	_to_move = get_parent()
	
	if _to_move.get("speed"):
		_speed = _to_move.speed
	elif _to_move.get("_speed"):
		_speed = _to_move._speed
		
	TheWitchManager.position_updated.connect(_on_witch_position_updated)


func _physics_process(delta: float) -> void:
		# Moves towards the witch
		var distance = _goal_position - global_position
		var direction = distance.normalized()
		_to_move.move_and_collide(direction * _speed * delta)

	
func _on_witch_position_updated(witch_position: Vector2) -> void:
	_goal_position = witch_position
