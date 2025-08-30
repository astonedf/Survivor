class_name Character extends CharacterBody2D


@export var allegiances: Array[Enums.Allegiances] = []
@export var hostile_to: Array[Enums.Allegiances] = []


func is_hostile_to(other_character: Character):
	var hostile = false
	
	for enemy in hostile_to:
		for other_character_allegiance in other_character.allegiances:
			if enemy == other_character_allegiance:
				hostile = true
	
	return hostile
