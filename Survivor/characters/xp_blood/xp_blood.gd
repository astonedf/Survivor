class_name XpBlood extends Node2D

@export_custom(PROPERTY_HINT_NONE, "suffix:s") var collecting_time := 5
@export_custom(PROPERTY_HINT_NONE, "suffix:xp") var xp := 0
@export_range(0, 100, 1, "suffix:%")  var _drop_chance := 0
const pickup_scene: PackedScene = preload("res://characters/xp_blood/xp_blood_pickup.tscn")


func spawn(pickup_position: Vector2) -> void:
	if randf() <= (_drop_chance / 100.0):
		var pickup: XpBloodPickup = pickup_scene.instantiate()
		pickup.collecting_time = collecting_time
		pickup.xp = xp
		pickup.global_position = pickup_position
		get_tree().current_scene.add_child(pickup)
