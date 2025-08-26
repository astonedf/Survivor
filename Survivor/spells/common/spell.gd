class_name Spell extends Node2D
## Base class for all spells.


enum SpellType {FIRE, WATER, ELECTRIC, EARTH, PLANT, WIND}

@export var spell_type: SpellType
@export var _auto_cast := true
@export var is_single_target := true

## Time before the spell can be casted again. In Seconds.
@export_range(0.06, 10.0, 0.01, "suffix:s") var _cooldown: float = 1.0
@export var caster: Character = null
var target: Node2D = null

var _on_cooldown := false
var _cooldown_timer := Timer.new()


func _ready() -> void:
	_cooldown_timer.wait_time = _cooldown
	_cooldown_timer.one_shot = true
	add_child(_cooldown_timer)
	_cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)


## Starts the cooldown timer.
## If duration and tick_rate are both greather than 0, it starts their timers too,
func cast() -> void:
	# Overriden in children classes
	_on_cooldown = true
	_cooldown_timer.start()
	
	
## If auto_cast is true, will call _cast again
func _on_cooldown_timer_timeout() -> void:
	_on_cooldown = false
	
	if _auto_cast:
		cast()
