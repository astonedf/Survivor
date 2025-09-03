class_name SpellBook

var spells: Array[Spell] = []

func add_spell(spell: Spell) -> void:
	spells.append(spell)
	
	
func get_spells() -> Array[Spell]:
	return spells.duplicate()
