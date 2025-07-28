class_name Character extends CharacterBody2D

signal damage_taken(amount: float)

@export var _health := 1.0
@export var _can_move := true
@export var _speed := 0.0
@export var _can_take_damage := true
@export var _armor := 0.0

# Area where damage is received when entered by something
var _damageable_area: Area2D = null


func _ready() -> void:
	_damageable_area = get_node("DamageableArea")
	_damageable_area.body_entered.connect(_on_damageable_area_body_entered)
	_damageable_area.area_entered.connect(_on_damageable_area_area_entered)


func _on_damageable_area_body_entered(body: Node2D) -> void:
	# Overriden in children classes
	pass
		

func  _on_damageable_area_area_entered(area: Area2D) -> void:
	# Overriden in children classes
	pass

		
func _take_damage(raw_amount: float) -> void:
	if _can_take_damage:
		var final_amount = raw_amount - _armor
		
		_health -= final_amount
		damage_taken.emit(final_amount)
		
		if _health <= 0:
			queue_free()
