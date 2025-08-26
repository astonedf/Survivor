class_name Enemy extends Character
## Contains the behavior common to all enemies

## How much XP is given on death
@export var xp_given := 0

var _goal_position := Vector2()


func _ready() -> void:
	super._ready()
	TheWitchManager.position_updated.connect(_on_witch_position_updated)
	
	
func _physics_process(delta: float) -> void:
	if _can_move:
		# Moves towards the witch
		var distance = _goal_position - global_position
		var direction = distance.normalized()
		velocity = direction * _speed
		var collision_info = move_and_collide(velocity * delta)

		
func _on_witch_position_updated(witch_position: Vector2) -> void:
	_goal_position = witch_position
	
	
func _on_damageable_area_body_entered(body: Node2D) -> void:
	if body is SpellProjectile and body.caster is TheWitch:
		if body.is_single_target:
			if body.target == self:
				_take_damage(body, body.damage)
		else:
			_take_damage(body, body.damage)


func  _on_damageable_area_area_entered(area: Area2D) -> void:
	pass
	
	
func _take_damage(source: Node2D, raw_amount: int):
	if _can_take_damage:
		var final_amount = raw_amount - _armor
		
		if final_amount > 0:
			_health -= final_amount
			damage_taken.emit(source, final_amount)
			
			if _health <= 0:
				_die(source)
	
	
func _die(source: Node2D):
	super._die(source)
	
	var xp_blood = xp_scene.instantiate()
	xp_blood.position = global_position
	get_parent().add_child(xp_blood)
	TheWitchManager.receive_xp(xp_given)
	queue_free()
