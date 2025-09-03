class_name TheWitchCharacter extends Character


@export var speed: int
var _destination: Vector2
var _target_position: Vector2
var _direction


func _ready() -> void:
	_destination = global_position
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("RMB"):
		_destination = get_global_mouse_position()


func _physics_process(delta):
	TheWitchManager.position_updated.emit(global_position)
	
	var mouse_distance = position.distance_to(get_global_mouse_position())
	mouse_distance = remap(mouse_distance, 100, 1000, 0.1, 1)
	
	if _destination.x > position.x:
		_direction = 1
	else:
		_direction = -1
	
	if position.distance_to(_destination) > 3:
		_target_position = (_destination - position).normalized()
		velocity = _target_position * speed
		move_and_slide()
	else:
		velocity = Vector2(0,0)
		
	handle_movement_anim(_direction)
	
			
func _on_weapon_pickup_range_area_body_entered(weapon: Weapon) -> void:
	weapon.pickup(self)

			
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
