@tool
class_name DetectionArea extends Node2D
## An area that can detect bodies, like the closest body.
## It does not emit a signal, to avoid doing heavy work if not necessary.
## Spells, for example, can call the functions when they need a target, for example
## when they are casted.


@export var _area: Area2D = null:
	set(value):
		_area = value
		if Engine.is_editor_hint():
			update_configuration_warnings()
			

## Point from where to detect the closest body.
@export var _origin: Node2D = null


func get_closest_body() -> Node2D:
	var closest_body: Node2D = null
	var shortest_distance = 100000
	var bodies = _area.get_overlapping_bodies()
	
	for body in bodies:
		if body != _origin:
			var distance_from_origin = _origin.global_position.distance_to(body.global_position)
			
			if distance_from_origin < shortest_distance:
				shortest_distance = distance_from_origin
				closest_body = body

	return closest_body


func _get_configuration_warnings() -> PackedStringArray :
	var errors: PackedStringArray = []
	
	if _area == null:
		errors.append("Add an Area2D as a property to be able to detect things")
		
	return errors
