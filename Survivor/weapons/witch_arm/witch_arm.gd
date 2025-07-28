extends Weapon

## Hit rate of the arm when the LMB is held down
@export_range(0.01, 1.0, 0.01, "suffix:s") var hit_rate: float

@onready var arm_sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var hit_timer: Timer = $HitTimer


func _ready() -> void:
	collision_shape.disabled = true
	hit_timer.wait_time = hit_rate
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		collision_shape.disabled = false
		hit_timer.start()
		arm_sprite.scale = Vector2(0.75, 0.75)
	if event.is_action_released("LMB"):
		hit_timer.stop()
		collision_shape.disabled = true
		arm_sprite.scale = Vector2(1.0, 1.0)
		

func _physics_process(delta: float) -> void:
	arm_sprite.position = get_local_mouse_position()
	collision_shape.position = get_local_mouse_position()


func _on_hit_timer_timeout() -> void:
	collision_shape.disabled = !collision_shape.disabled
