extends Weapon


@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	super._ready()
	collision_shape.disabled = true
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		# Allows to hit one time directly without waiting the end of the first tick rate
		collision_shape.disabled = false
		_tick_rate_timer.start()
	if event.is_action_released("LMB"):
		_tick_rate_timer.stop()
		collision_shape.disabled = true
		

func _physics_process(delta: float) -> void:
	collision_shape.position = get_local_mouse_position()


func _on_tick_rate_timer_timeout() -> void:
	collision_shape.disabled = !collision_shape.disabled
