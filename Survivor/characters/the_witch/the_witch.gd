class_name TheWitch extends Character


@onready var broom: Weapon = $Broom


var flower_in_range = []
var enemy_in_range = false
var destination: Vector2
var target_position: Vector2
var direction


func _ready() -> void:
	super._ready()
	broom.pickup(self)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("RMB"):
		_can_move = true
		destination = get_global_mouse_position()


func _physics_process(delta):
	TheWitchManager.position_updated.emit(global_position)
	
	if _can_move:
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


func _on_weapon_pickup_range_area_body_entered(weapon: Weapon) -> void:
	weapon.pickup(self)


func _on_damageable_area_body_entered(weapon: Weapon) -> void:
	if weapon._holder is Enemy:
		_take_damage(weapon._damage)


func  _on_damageable_area_area_entered(area: Area2D) -> void:
	pass
