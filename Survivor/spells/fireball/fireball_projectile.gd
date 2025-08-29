class_name FireballProjectile extends CharacterBody2D

var spell_type: Enums.Elements
var damage := 0
var speed := 0
var target: Node2D = null
var _casted := false
var caster: Character
var previous_direction = null


@onready var follow_target: FollowTarget = $FollowTarget


func cast():
	_casted = true
	follow_target.can_move = true
	

func prepare(caster_: Character, spell_type_: Enums.Elements, damage_: int, target_: Node2D, speed_: int) -> void:
	caster = caster_
	spell_type = spell_type_
	damage = damage_
	target = target_
	speed = speed_
	
	follow_target.target = target
	follow_target.speed = speed


func _on_affectable_area_entered(aoe: AreaOfEffect, affectable_area: AffectableArea) -> void:
	# Single target
	if affectable_area.source == target:
		affectable_area.take_damage(aoe, spell_type, damage)


func _on_area_of_effect_damage_done(to: Node2D, amount: int) -> void:
	queue_free()
