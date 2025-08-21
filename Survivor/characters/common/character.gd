class_name Character extends CharacterBody2D
## Base class for TheHand, TheWitch, Enemy and Npc

signal damage_taken(amount: int)

@export var max_health := 1
@export var _can_move := true
@export var _speed := 0.0
@export var _can_take_damage := true
@export var _armor := 0

var _health := 1
var xp_scene = preload("res://characters/common/xp_blood/xp_blood.tscn")

# Area where damage is received when entered by something
var _damageable_area: Area2D = null


func _ready() -> void:
	_health = max_health
	_damageable_area = get_node("DamageableArea")
	_damageable_area.body_entered.connect(_on_damageable_area_body_entered)
	_damageable_area.area_entered.connect(_on_damageable_area_area_entered)
	

## Damageable areas are set to detect only the weapons layer for now.
## To make something damage characters, it must then be on the weapons layer.
func _on_damageable_area_body_entered(body: Weapon) -> void:
	# Overriden in children classes
	pass
	
		
## Damageable areas are set to detect only the weapons layer for now.
## To make something damage characters, it must then be on the weapons layer.
func  _on_damageable_area_area_entered(area: Area2D) -> void:
	# Overriden in children classes
	pass

		
func _take_damage(raw_amount: int) -> void:
	if _can_take_damage:
		var final_amount = raw_amount - _armor
		
		if final_amount > 0:
			_health -= final_amount
			damage_taken.emit(final_amount)
			
			if _health <= 0:
				_die()


func _die():
	# Overriden in children
	pass
