extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	super._ready()
	
	if _holder == null:
		animation_player.play("grounded")


func _on_hit_rate_timer_timeout() -> void:
	animation_player.play("jump")
	_hit_duration_timer.start()
	
	
func _on_hit_duration_timer_timeout() -> void:
	_hit_rate_timer.start()
	

func pickup(new_holder: Character) -> void:
	if _pickable:
		super.pickup(new_holder)
		animation_player.play("RESET")
		await animation_player.animation_finished
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(), 0.2)
		_hit_rate_timer.start()
