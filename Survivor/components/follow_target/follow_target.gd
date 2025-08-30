class_name FollowTarget extends Node2D


@export var to_move: CharacterBody2D
@export var target: Character
@export var can_move := false
var previous_direction := Vector2()
var speed := 0


func _physics_process(delta: float) -> void:
	if can_move and target != null:
		## If the target is freed, it will move in a straight line
		previous_direction = (target.global_position - global_position).normalized()
		
	var direction = previous_direction
	var velocity = direction * speed
	to_move.move_and_collide(velocity * delta)
