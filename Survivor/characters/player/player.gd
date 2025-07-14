extends CharacterBody2D

@onready var bullet = preload("res://weapons/bullet/bullet.tscn")
var speed = 100  # speed in pixels/sec
var flower_in_range = []
var enemy_in_range = false
var destination: Vector2
var target_position: Vector2


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("RMB"):
		destination = get_global_mouse_position()
	if event.is_action_pressed("LMB"):
		shoot()


func _physics_process(delta):
	PlayerManager.position_updated.emit(global_position)
	look_at(get_global_mouse_position())

	var mouse_distance = position.distance_to(get_global_mouse_position())
	mouse_distance = remap(mouse_distance, 100, 1000, 0.1, 1)
	
	if position.distance_to(destination) > 3:
		target_position = (destination - position).normalized()
		velocity = target_position * speed

		move_and_slide()


func shoot():
	var instance = bullet.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	get_parent().add_child.call_deferred(instance)
	
