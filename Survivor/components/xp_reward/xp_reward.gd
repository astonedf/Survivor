class_name XpReward extends Node


@export_custom(PROPERTY_HINT_NONE, "suffix:xp") var amount := 0


func reward_xp() -> void:
	TheWitchManager.give_xp(amount)
