class_name Player extends Character

@onready var bullet = preload("res://weapons/bullet/bullet.tscn")
@onready var witch_arm: Weapon = $WitchArm
@onready var witch_broom: Weapon = $WitchBroom
@onready var hit_timer: Timer = $HitTimer

var flower_in_range = []
var enemy_in_range = false
var destination: Vector2
var target_position: Vector2
var direction
var attacking_animation_playing: bool = false
	

func _ready() -> void:
	super._ready()
	witch_arm.pickup(self)
	witch_broom.pickup(self)
	hit_timer.start()
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("RMB"):
		_can_move = true
		destination = get_global_mouse_position()


func _physics_process(delta):
	PlayerManager.position_updated.emit(global_position)
	
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
	if !attacking_animation_playing:
		if !velocity:
			$AnimationPlayer.play("Idle")
		if velocity:
			$AnimationPlayer.play("Walk")
			toggle_flip_sprite(dir)

func toggle_flip_sprite(dir):
	if dir == 1:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true


func shoot():
	var instance = bullet.instantiate()
	instance.dir = $Spray.rotation
	instance.spawnPos = global_position
	instance.spawnRot = $Spray.rotation
	get_parent().add_child.call_deferred(instance)
	

func _on_hit_timer_timeout() -> void:
	attacking_animation_playing = true
	$AnimationPlayer.play("Hit")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		attacking_animation_playing = false


func _on_weapon_pickup_range_area_body_entered(weapon: Weapon) -> void:
	weapon.pickup(self)


func _on_damageable_area_body_entered(weapon: Weapon) -> void:
	if weapon._holder is Enemy:
		_take_damage(weapon._damage)


func  _on_damageable_area_area_entered(area: Area2D) -> void:
	pass
