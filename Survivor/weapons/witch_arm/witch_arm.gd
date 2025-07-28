extends Weapon

@onready var arm_sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	super._ready()
	collision_shape.disabled = true
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		# Allows to hit one time directly without waiting the end of the first tick rate
		collision_shape.disabled = false
		_tick_rate_timer.start()
		arm_sprite.scale = Vector2(0.75, 0.75)
	if event.is_action_released("LMB"):
		_tick_rate_timer.stop()
		collision_shape.disabled = true
		arm_sprite.scale = Vector2(1.0, 1.0)
		

func _physics_process(delta: float) -> void:
	arm_sprite.position = get_local_mouse_position()
	collision_shape.position = get_local_mouse_position()


func _on_tick_rate_timer_timeout() -> void:
	collision_shape.disabled = !collision_shape.disabled
