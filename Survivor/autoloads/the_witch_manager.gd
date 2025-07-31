extends Node

signal position_updated(position: Vector2)
signal xp_updated(xp: int)
signal xp_received(amount_received: int)
signal lvl_updated(lvl: int)

var _xp := 0
var _lvl := 1
var _xp_to_reach_next_lvl: int:
	get:
		return _xp_to_reach_lvl(_lvl + 1)
	set(value):
		pass


func receive_xp(amount: int) -> void:
	xp_received.emit(amount)
	_compute_xp(amount)
	

func _compute_xp(amount: int) -> void:
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
	_compute_xp(remaining_xp)
	
	
func _xp_to_reach_lvl(lvl: int) -> int:
	var xp_for_lvl_1 = 100
	var xp_requirement_grow_rate = 1.2

	return xp_for_lvl_1 * pow(xp_requirement_grow_rate, (lvl - 1))
		
