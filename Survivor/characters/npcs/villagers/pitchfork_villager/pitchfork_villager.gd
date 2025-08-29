class_name PitchforkVillager extends Character

@onready var health: Health = $Health

	
func _on_affectable_area_damage_taken(source: Node2D, damage: int) -> void:
	health.take_damage(source, damage)


func _on_affectable_area_heal_received(source: Node2D, heal: int) -> void:
	health.receive_heal(source, heal)


func _on_health_died(source: Node2D) -> void:
	queue_free()
