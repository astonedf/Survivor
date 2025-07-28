extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _attack() -> void:
	super._attack()
	animation_player.play("jump")


func _on_timer_timeout() -> void:
	_attack()
	

func pickup(new_holder: Character) -> void:
	super.pickup(new_holder)
