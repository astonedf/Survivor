class_name Weapon extends CharacterBody2D
## Base class for all weapons.
##
## Provides timers that may or may not be used by weapons, depending on how
## they work.


@export var _damage := 1.0
## Can be picked up ?
## Set to false when the weapon is picked up.
@export var _pickable := true
## Hit rate of the weapon.
## It will start a new hit every hit_rate.
## It is set to one shot and the count must start when hit_duration is finished.
@export_range(0.06, 10.0, 0.01, "suffix:s") var hit_rate: float = 1.0
## Duration of the hit.
## This is the time frame during which the collision shapes are active.
## Without this, the weapon will hit during the full time frame between each hit.
## It is set to one shot and the count must start when hit_rate is finished.
@export_range(0.06, 10.0, 0.01, "suffix:s") var hit_duration: float = 0.4
## Will inflict damage every tick during hit_duration.
## This is used for weapons that inflict damage multiple times during their duration.
@export_range(0.06, 10.0, 0.01, "suffix:s") var tick_rate: float = 0.4

var _holder: Character = null
var _hit_rate_timer := Timer.new()
var _hit_duration_timer := Timer.new()
var _tick_rate_timer := Timer.new()

func _ready() -> void:
	_hit_rate_timer.wait_time = hit_rate
	_hit_duration_timer.wait_time = hit_duration
	_tick_rate_timer.wait_time = tick_rate
	_hit_rate_timer.one_shot = true
	_hit_duration_timer.one_shot = true
	add_child(_hit_rate_timer)
	add_child(_hit_duration_timer)
	add_child(_tick_rate_timer)
	_hit_rate_timer.timeout.connect(_on_hit_rate_timer_timeout)
	_hit_duration_timer.timeout.connect(_on_hit_duration_timer_timeout)
	_tick_rate_timer.timeout.connect(_on_tick_rate_timer_timeout)
	

func _on_hit_rate_timer_timeout() -> void:
	# Overriden in children classes
	pass
	
	
func _on_hit_duration_timer_timeout() -> void:
	# Overriden in children classes
	pass
	
	
func _on_tick_rate_timer_timeout() -> void:
	# Overriden in children classes
	pass
	
	
func pickup(new_holder: Character) -> void:
	if _pickable:
		_holder = new_holder
		_pickable = false
		call_deferred("reparent", _holder)
		
		
