class_name XpBloodPickup extends Node2D

@onready var blood_sprite: Sprite2D = $Blood
@onready var spawn_spill: CPUParticles2D = $SpawnSpill
@onready var hover_spill: CPUParticles2D = $HoverSpill
@onready var collecting_spill: CPUParticles2D = $CollectingSpill
@onready var collecting_timer: Timer = $CollectingTimer
@onready var regression_timer: Timer = $RegressionTimer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var xp_reward: XpReward = $XpReward
var collecting_time := 0
var xp := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	# collecting_time is in seconds, progress bar step is 1 and timers
	# adds/remove a step every 0.1s
	progress_bar.hide()
	progress_bar.max_value = collecting_time * 10
	xp_reward.amount = xp
	spawn_spill.emitting = true
	show()


func _on_area_2d_mouse_entered() -> void:
	hover_spill.emitting = true


func _on_area_2d_mouse_exited() -> void:
	_stop_collecting()
	hover_spill.emitting = false


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("LMB"):
		_start_collecting()
	if event.is_action_released("LMB"):
		hover_spill.emitting = true
		_stop_collecting()


func _start_collecting() -> void:
	regression_timer.stop()
	collecting_timer.start()
	collecting_spill.emitting = true
	hover_spill.emitting = false
	
	
func _stop_collecting() -> void:
	collecting_timer.stop()
	regression_timer.start()
	collecting_spill.emitting = false


func _on_collecting_timer_timeout() -> void:
	progress_bar.value += progress_bar.step


func _on_regression_timer_timeout() -> void:
	progress_bar.value -= progress_bar.step


func _on_progress_bar_value_changed(value: float) -> void:
	if value == 0.0:
		progress_bar.hide()
	else:
		progress_bar.show()
		
		if value == progress_bar.max_value:
			xp_reward.reward_xp()
			queue_free()
		
