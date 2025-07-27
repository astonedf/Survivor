extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var label: Label = $Label

var parent: Character = null

func _ready() -> void:
	# Sets the health bar properties with the parent's 
	parent = get_parent()
	progress_bar.max_value = parent._health
	progress_bar.value = parent._health
	_update_label()
	parent.damage_taken.connect(_on_damage_taken)
	

func _on_damage_taken(amount: float) -> void:
	progress_bar.value -= amount
	_update_label()


func _update_label() -> void:
	label.text = str(progress_bar.value) + " / " + str(progress_bar.max_value)
