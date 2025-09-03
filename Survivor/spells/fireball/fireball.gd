class_name Fireball extends Node2D

const projectile_scene = preload("res://spells/fireball/fireball_projectile.tscn")

@export_custom(PROPERTY_HINT_NONE, "suffix:hp") var damage := 0
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var speed := 0

@onready var detection_area: DetectionArea = $DetectionArea
var _target: Character = null
var _caster: Character = null


func cast() -> void:
	detection_area._origin = self
	
	var closest_target: Character = detection_area.get_closest_body()
		
	if closest_target != null:
		if _caster.is_hostile_to(closest_target):
			_target = closest_target
	## Spawn a projectile
	if _target != null:
		var new_projectile: FireballProjectile = projectile_scene.instantiate()
		new_projectile.global_position = self.global_position
		get_tree().current_scene.add_child(new_projectile)
		new_projectile.prepare(_caster, Enums.Elements.FIRE, damage, _target, speed)
		new_projectile.cast()
