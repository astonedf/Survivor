class_name AffectableArea extends Area2D
## Defines an area that's damageable, healable, etc.

signal damage_taken(source: Node2D, damage: int)
signal heal_received(source: Node2D, heal: int)

@export var can_be_damaged := true
@export var can_be_healed := true

var source: Node2D


## Is directly substracted from physical damage
@export var _armor := 0
@export_range(0, 100, 1, "suffix:%")  var _fire_resistance := 0
@export_range(0, 100, 1, "suffix:%")  var _water_resistance := 0
@export_range(0, 100, 1, "suffix:%")  var _electric_resistance := 0
@export_range(0, 100, 1, "suffix:%")  var _earth_resistance := 0
@export_range(0, 100, 1, "suffix:%")  var _plant_resistance := 0
@export_range(0, 100, 1, "suffix:%")  var _wind_resistance := 0
# To simplify code. Must be in same order than Enums.Elements.
# Exported elemental resistances will be stored in this
var _resistances: Array[int]


func _ready() -> void:
	source = get_parent()
	_resistances = [_fire_resistance, _water_resistance, _electric_resistance, _earth_resistance, _plant_resistance, _wind_resistance]
	
	if _resistances.size() != Enums.Elements.size():
		printerr("Check _resistances size. It must correspond to Enums.Elements")
	
	
func take_damage(aoe: AreaOfEffect, damage_type: Enums.Elements, damage: int) -> void:
	if can_be_damaged:
		var raw_amount = damage
		var amount = raw_amount - round((raw_amount * _resistances[damage_type] / 100.0))
		
		aoe.damage_done.emit(self.source, amount)
		damage_taken.emit(aoe.source, amount)


func heal(aoe: AreaOfEffect, heal_type: Enums.Elements, heal: int) -> void:
	if can_be_healed:
		var raw_amount = heal
		var amount = raw_amount
		aoe.heal_done.emit(self.source, amount)
		heal_received.emit(aoe.source, heal)
