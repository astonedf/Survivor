extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer


func _ready() -> void:
	if _holder == null:
		animation_player.play("grounded")
		

func _attack() -> void:
	super._attack()
	animation_player.play("jump")


func _on_timer_timeout() -> void:
	_attack()
	

func pickup(new_holder: Character) -> void:
	if _pickable:
		super.pickup(new_holder)
		animation_player.play("RESET")
		await animation_player.animation_finished
		reparent(new_holder)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(), 0.2)
		timer.start()
