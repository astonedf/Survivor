extends Node2D

@onready var spawn_path: PathFollow2D = $SpawnPath/PathFollow2D
@onready var spawn_point: Marker2D = $SpawnPath/PathFollow2D/SpawnPoint

var _spawn_container: Node
var _available_enemies: Array[PackedScene] = [
	preload("res://characters/npcs/villagers/pitchfork_villager/pitchfork_villager.tscn")
]


func _ready() -> void:
	_spawn_container = get_parent().get_parent()


func _physics_process(delta: float) -> void:
	# Avoid the spawn path to rotate with the witch
	global_rotation = 0.0


func _on_spawn_timer_timeout() -> void:
	# spawn_point will move automatically with the progress ratio of the path
	if _available_enemies.size() > 0:
		spawn_path.progress_ratio = randf()
		var enemy: Character = _available_enemies[randi_range(0, _available_enemies.size() - 1)].instantiate()
		enemy.global_position = spawn_point.global_position
		_spawn_container.add_child(enemy)
