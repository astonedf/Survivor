extends Weapon


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_left: CollisionShape2D = $CollisionShapeLeft
@onready var collision_shape_right: CollisionShape2D = $CollisionShapeRight

var _direction := 1
var _attacking = false


func _ready() -> void:
	super._ready()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("RMB"):
		if get_local_mouse_position().x > position.x:
			_direction = 1
			sprite_2d.flip_h = false
			sprite_2d.position = collision_shape_right.position
			_update_collision_shapes()
		else:
			_direction = -1
			sprite_2d.flip_h = true
			sprite_2d.position = collision_shape_left.position
			_update_collision_shapes()


func _on_attack_rate_timer_timeout() -> void:
	_attacking = true
	_update_collision_shapes()
	sprite_2d.flip_v = true
	_attack_duration_timer.start()

	
func _on_attack_duration_timer_timeout() -> void:
	_attacking = false
	_attack_rate_timer.start()
	sprite_2d.flip_v = false
	collision_shape_left.disabled = true
	collision_shape_right.disabled = true
	

func _update_collision_shapes():
	if _attacking:
		if _direction == 1:
			collision_shape_left.disabled = true
			collision_shape_right.disabled = false
		else:
			collision_shape_left.disabled = false
			collision_shape_right.disabled = true
	else:
		collision_shape_left.disabled = true
		collision_shape_right.disabled = true
	
	
func pickup(new_holder: Character) -> void:
	super.pickup(new_holder)
	_attack_rate_timer.start()
