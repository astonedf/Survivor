extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	super._ready()
	
	if _holder == null:
		animation_player.play("grounded")


func _on_attack_rate_timer_timeout() -> void:
	animation_player.play("jump")
	_attack_duration_timer.start()
	
	
func _on_attack_duration_timer_timeout() -> void:
	_attack_rate_timer.start()
	

func pickup(new_holder: Character) -> void:
	if _pickable:
		super.pickup(new_holder)
		animation_player.play("RESET")
		await animation_player.animation_finished
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(), 0.2)
		_attack_rate_timer.start()
