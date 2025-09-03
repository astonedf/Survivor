class_name SpellEntry extends Control


@onready var texture_rect: TextureRect = $HBoxContainer/TextureRect
@onready var spell_name: Label = $HBoxContainer/SpellName


func add_spell(spell: Spell):
	texture_rect.texture = spell.icon
	spell_name.text = tr(spell.name_key)
