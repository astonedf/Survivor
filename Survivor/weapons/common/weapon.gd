class_name Weapon extends CharacterBody2D
## Base class for all weapons


@export var _damage := 1.0

## Can be picked up ?
## Set to false when the weapon is picked up.
@export var _pickable := true

var _holder: Character = null


func _attack() -> void:
	pass


func pickup(new_holder: Character) -> void:
	if _pickable:
		_holder = new_holder
		_pickable = false
