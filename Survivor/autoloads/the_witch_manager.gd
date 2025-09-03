extends Node

signal position_updated(position: Vector2)
signal xp_updated(xp: int)
signal xp_received(amount_received: int)
signal lvl_updated(lvl: int)


var _the_witch: TheWitch


func _ready() -> void:
	_the_witch = TheWitch.new()
	_the_witch.give_spell(load("res://data/spells/fireball.tres"))

	
func get_spells() -> Array[Spell]:
	return _the_witch.get_spells()


func get_xp() -> int:
	return _the_witch.get_xp()
	

func get_xp_to_reach_next_lvl() -> int:
	return _the_witch.get_xp_to_reach_next_lvl()
	
	
func get_lvl() -> int:
	return _the_witch.get_lvl()


func give_xp(amount: int) -> void:
	xp_received.emit(amount)
	_the_witch.give_xp(amount)
