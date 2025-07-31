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
	
	
func _on_damageable_area_body_entered(weapon: Weapon) -> void:
	if weapon._holder is TheWitch or weapon._holder is TheHand:
		_take_damage(weapon._damage)


func  _on_damageable_area_area_entered(area: Area2D) -> void:
	pass
	

func _die():
	TheWitchManager.receive_xp(xp_given)
	queue_free()
