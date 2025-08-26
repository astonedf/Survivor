@tool
class_name ProjectileSpell extends Spell

@export var projectile_scene: PackedScene = null:
	set(value):
		projectile_scene = value
		if Engine.is_editor_hint():
			update_configuration_warnings()
			
@export var projectile_damage := 0
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var projectile_speed := 0
@export var detection_area: DetectionArea = null:
	set(value):
		detection_area = value
		if Engine.is_editor_hint():
			update_configuration_warnings()


func _ready() -> void:
	super._ready()
	
	
func cast() -> void:
	super.cast()
	
	if detection_area._origin == null:
		detection_area._origin = caster
	
	## Spawn a projectile
	if projectile_scene != null and detection_area != null:
		var closest_target = detection_area.get_closest_body()
		
		if closest_target != null:
			var new_projectile: SpellProjectile = projectile_scene.instantiate()
			new_projectile.prepare(caster, spell_type, projectile_damage, closest_target, projectile_speed)
			new_projectile.global_position = self.global_position
			get_tree().current_scene.add_child(new_projectile)
			new_projectile.cast()


func _get_configuration_warnings() -> PackedStringArray :
	var errors: PackedStringArray = []
	
	if projectile_scene == null:
		errors.append("Add a projectile scene in properties to be able to cast")
	
	if detection_area == null:
		errors.append("Add a detection area in properties to detect ennemies")
		
	return errors
