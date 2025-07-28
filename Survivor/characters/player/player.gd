class_name Player extends Character

@onready var bullet = preload("res://weapons/bullet/bullet.tscn")

var flower_in_range = []
var enemy_in_range = false
var destination: Vector2
var target_position: Vector2
var direction
var look_right_pos = Vector2(32,0)
var look_left_pos = Vector2(-32,0)
var attacking: bool = false
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("RMB"):
		_can_move = true
		destination = get_global_mouse_position()
	if event.is_action_pressed("LMB"):
		#shoot()
		$CrushArea/CrushColl.disabled = false
	if event.is_action_released("LMB"):
		$CrushArea/CrushColl.disabled = true


func _physics_process(delta):
	PlayerManager.position_updated.emit(global_position)
	
	$CanvasLayer/Arm.position = get_viewport().get_mouse_position()
	$CrushArea.position = get_local_mouse_position()
	
	if _can_move:
		$Spray.look_at(get_global_mouse_position())

		var mouse_distance = position.distance_to(get_global_mouse_position())
		mouse_distance = remap(mouse_distance, 100, 1000, 0.1, 1)
		
		if destination.x > position.x:
			direction = 1
		else:
			direction = -1
		
		if position.distance_to(destination) > 3:
			target_position = (destination - position).normalized()
			velocity = target_position * _speed
			move_and_slide()
		else:
			velocity = Vector2(0,0)
		
		handle_movement_anim(direction)
			
func handle_movement_anim(dir):
	if !attacking:
		if !velocity:
			$AnimationPlayer.play("Idle")
		if velocity:
			$AnimationPlayer.play("Walk")
			toggle_flip_sprite(dir)

func toggle_flip_sprite(dir):
	if dir == 1:
		$Sprite2D.flip_h = false
		$Sprite2D.position = look_right_pos
		$HitArea/HitLeft.disabled = true
		$HitArea/HitRight.disabled = false
	else:
		$Sprite2D.flip_h = true
		$Sprite2D.position = look_left_pos
		$HitArea/HitLeft.disabled = false
		$HitArea/HitRight.disabled = true

func shoot():
	var instance = bullet.instantiate()
	instance.dir = $Spray.rotation
	instance.spawnPos = global_position
	instance.spawnRot = $Spray.rotation
	get_parent().add_child.call_deferred(instance)
	


func _on_hit_timer_timeout() -> void:
	attacking = true
	$AnimationPlayer.play("Hit")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		attacking = false


func _on_weapon_pickup_range_area_body_entered(body: Weapon) -> void:
	body.pickup(self)
