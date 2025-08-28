class_name Health extends Node2D


signal died(source: Node2D)

@export_custom(PROPERTY_HINT_NONE, "suffix: hp") var max_health := 0
@export var show_health_bar := true
@export var show_label := false

@onready var health_bar: ProgressBar = $ProgressBar
@onready var label: Label = $Label
var health: int


func _ready() -> void:
	health = max_health
	health_bar.hide()
	label.hide()
	
	if show_health_bar:
		health_bar.show()
		health_bar.max_value = max_health
		health_bar.value = max_health
	
	if show_label:
		label.show()
		_update_label(max_health, max_health)
	

func take_damage(source: Node2D, amount: int) -> void:
	health -= amount
	
	if show_health_bar:
		health_bar.value -= amount
	
	if show_label:
		_update_label(health, max_health)
		
	if health <= 0:
		died.emit(source)
		

func receive_heal(source: Node2D, amount: int) -> void:
	health += amount
	
	if health > max_health:
		health = max_health


func _update_label(health: int, max_health: int) -> void:
	label.text = str(health) + " / " + str(max_health)
