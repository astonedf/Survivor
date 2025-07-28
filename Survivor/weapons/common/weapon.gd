class_name Weapon extends CharacterBody2D


@export var _damage := 1.0

var _holder: Character = null


func _attack() -> void:
	pass


func pickup(new_holder: Character) -> void:
	_holder = new_holder
