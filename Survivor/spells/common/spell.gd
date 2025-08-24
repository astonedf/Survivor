class_name Spell extends Node
## Base class for all spells.
##
## Provides timers that may or may not be used by spells, depending on how
## they work.

enum SpellType {FIRE, WATER, ELECTRIC, EARTH, PLANT, WIND}
enum TargettingType {
		CLOSEST_ENEMY, RANDOM_ENEMY, SELECTED_ENEMY,
		CLOSEST_ALLY, RANDOM_ALLY, SELECTED_ALLY,
		RANDOM_DIRECTION, RANDOM_POSITION,
		SELF,
		ON_MOUSE
	}

@export var _auto_cast := true
@export var spell_type: SpellType
@export var _targetting_type: TargettingType

## Time before the spell can be casted again. In Seconds.
@export_range(0.06, 10.0, 0.01, "suffix:s") var _cooldown: float = 1.0
## Duration of the spell. In Seconds.
@export_range(0.06, 10.0, 0.01, "suffix:s") var _duration: float = 1.0
## Will inflict damage every tick during attack_duration. In Seconds
@export_range(0.06, 10.0, 0.01, "suffix:s") var _tick_rate: float = 1.0

var _caster: Character = null
var _cooldown_timer := Timer.new()
var _duration_timer := Timer.new()
var _tick_rate_timer := Timer.new()

func _ready() -> void:
	_cooldown_timer.wait_time = _cooldown
	_duration_timer.wait_time = _duration
	_tick_rate_timer.wait_time = _tick_rate
	_cooldown_timer.one_shot = true
	_duration_timer.one_shot = true
	add_child(_cooldown_timer)
	add_child(_duration_timer)
	add_child(_tick_rate_timer)
	_cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	_duration_timer.timeout.connect(_on_duration_timer_timeout)
	_tick_rate_timer.timeout.connect(_on_tick_rate_timer_timeout)
	

func _on_cooldown_timer_timeout() -> void:
	# Overriden in children classes
	pass
	
	
func _on_duration_timer_timeout() -> void:
	# Overriden in children classes
	pass
	
	
func _on_tick_rate_timer_timeout() -> void:
	# Overriden in children classes
	pass
		
