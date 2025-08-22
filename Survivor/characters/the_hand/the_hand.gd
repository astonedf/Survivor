class_name TheHand extends Character

@onready var arm_sprite: Sprite2D = $ArmSprite
@onready var finger_crush: Weapon = $FingerCrush

func _ready() -> void:
	finger_crush.pickup(self)

	
func _physics_process(delta: float) -> void:
	arm_sprite.position = get_local_mouse_position()
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		arm_sprite.scale = Vector2(0.75, 0.75)
	if event.is_action_released("LMB"):
		arm_sprite.scale = Vector2(1.0, 1.0)
		
