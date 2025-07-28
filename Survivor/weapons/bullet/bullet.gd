class_name Bullet extends Weapon


@export var _speed := 500.0


var dir: float
var spawnPos: Vector2
var spawnRot: float

func _ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot


func _physics_process(delta: float) -> void:
	velocity = Vector2(_speed, 0).rotated(dir)
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()
