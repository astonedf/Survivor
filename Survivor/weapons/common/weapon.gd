class_name Weapon extends CharacterBody2D


enum State {GROUNDED, PICKED_UP}
@export var _damage := 1.0
@export var _state: State
var _holder: Character = null


func _attack() -> void:
	pass


func pickup(new_holder: Character) -> void:
	_holder = new_holder
