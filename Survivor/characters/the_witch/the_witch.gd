class_name TheWitch

var _spell_book: SpellBook
var _xp := 0
var _lvl := 1
var _xp_to_reach_next_lvl: int:
	get:
		return _xp_to_reach_lvl(_lvl + 1)
	set(value):
		pass
		
		
func _init() -> void:
	_spell_book = SpellBook.new()
	
	
func give_spell(spell: Spell):
	_spell_book.add_spell(spell)
	
	
func get_spells() -> Array[Spell]:
	return _spell_book.get_spells()


func give_xp(amount: int) -> void:
	_compute_xp(amount)
	

func get_xp() -> int:
	return _xp


func get_xp_to_reach_next_lvl() -> int:
	return _xp_to_reach_next_lvl
	
	
func get_lvl() -> int:
	return _lvl
	
	
func _compute_xp(amount: int) -> void:
	_xp += amount
	
	if _xp >= _xp_to_reach_next_lvl:
		var remaining_xp = _xp - _xp_to_reach_next_lvl
		_xp = 0
		_lvl_up(remaining_xp)
	else:
		TheWitchManager.xp_updated.emit(_xp)


func _lvl_up(remaining_xp: int) -> void:
	_lvl += 1
	TheWitchManager.lvl_updated.emit(_lvl)
	_compute_xp(remaining_xp)
	
	
func _xp_to_reach_lvl(lvl: int) -> int:
	var xp_for_lvl_1 = 100
	var xp_requirement_grow_rate = 1.2

	return xp_for_lvl_1 * pow(xp_requirement_grow_rate, (lvl - 1))
