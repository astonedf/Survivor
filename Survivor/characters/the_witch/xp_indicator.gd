extends Node2D

var _number_pop_scene = preload("res://ui/number_pop/number_pop.tscn")

func _ready() -> void:
	TheWitchManager.xp_received.connect(_on_xp_received)
	
	
func _on_xp_received(amount: int) -> void:
	var number_pop: NumberPop = _number_pop_scene.instantiate()
	add_child(number_pop)
	number_pop.pop("+" + str(amount) + " xp", Color(0.645, 0.552, 0.985))
