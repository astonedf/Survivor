extends Node

signal position_updated(position: Vector2)
signal xp_updated(xp: int)
signal lvl_updated(lvl: int)


var _xp := 0
var _lvl := 1
var _xp_to_reach_next_lvl: int:
	get:
		return _lvl * 100
	set(value):
		pass


func receive_xp(amount: int) -> void:
	_xp += amount
	
	if _xp >= _xp_to_reach_next_lvl:
		var remaining_xp = _xp - _xp_to_reach_next_lvl
		_xp = 0
		_lvl_up(remaining_xp)
	else:
		xp_updated.emit(_xp)


func _lvl_up(remaining_xp: int) -> void:
	_lvl += 1
	lvl_updated.emit(_lvl)
	receive_xp(remaining_xp)
		
