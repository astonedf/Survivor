class_name SpellBookWindow extends Control


@onready var spell_list: VBoxContainer = %SpellList
const spell_entry_scene: PackedScene = preload("res://ui/spell_book_window/spell_entry/spell_entry.tscn")

func _ready() -> void:
	hide()
	

func open(spells: Array[Spell]) -> void:
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	for child in spell_list.get_children():
		child.queue_free()
	
	for spell in spells:
		var spell_entry: SpellEntry = spell_entry_scene.instantiate()
		spell_list.add_child(spell_entry)
		spell_entry.add_spell(spell)
		
	show()


func close() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	hide()
	get_tree().paused = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("SpellBook"):
		if visible:
			close()
		else:
			open(TheWitchManager.get_spells())
