extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var label: Label = $Label

var parent: Character = null


func _ready() -> void:
	# Sets the health bar properties with the parent's 
	parent = get_parent()
	progress_bar.max_value = parent.max_health
	progress_bar.value = parent.max_health
	_update_label(parent.max_health, parent.max_health)
	parent.damage_taken.connect(_on_damage_taken)
	

func _on_damage_taken(amount: int) -> void:
	progress_bar.value -= amount
	_update_label(parent._health, parent.max_health)


func _update_label(health: int, max_health: int) -> void:
	label.text = str(health) + " / " + str(max_health)
