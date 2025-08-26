class_name SpellProjectile extends CharacterBody2D

var spell_type: Spell.SpellType
var damage := 0
var speed := 0
var target: Node2D = null
var _casted := false
var caster: Character
var previous_direction = null
var is_single_target := true


func _physics_process(delta: float) -> void:
	if _casted:
		if target != null:
			## If the target dies from another source, it will move in a straight line
			previous_direction = (target.global_position - global_position).normalized()
			
		var direction = previous_direction
		var velocity_ = direction * speed
		var collision_info = move_and_collide(velocity_ * delta)


func cast():
	_casted = true
	

func prepare(caster_: Character, spell_type_: Spell.SpellType, damage_: int, target_: Node2D, speed_: int, is_single_target_: bool) -> void:
	caster = caster_
	spell_type = spell_type_
	damage = damage_
	target = target_
	speed = speed_
	is_single_target = is_single_target_
	
	target.damage_taken.connect(_on_target_took_damage)


func _on_target_took_damage(source:Node2D, amount: int) -> void:
	if source == self:
		queue_free()
