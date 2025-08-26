@tool
class_name DetectionArea extends Node2D


@export var _area: Area2D = null:
	set(value):
		_area = value
		if Engine.is_editor_hint():
			update_configuration_warnings()

## Point from where to detect the closest body.
## If left to null, the origin will be the detection area origin
@export var _origin: Node2D = null

func _ready() -> void:
	if _origin == null:
		_origin = self
		
	
func get_closest_body() -> Node2D:
	var closest_body: Node2D = null
	var shortest_distance = 100000
	var bodies = _area.get_overlapping_bodies()
	var body_is_target_class = true
	
	for body in bodies:
		if body_is_target_class:
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
