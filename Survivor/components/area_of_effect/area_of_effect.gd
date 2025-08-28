class_name AreaOfEffect extends Area2D
## Can be used to define an area that does damage, heals, buffs, etc.
## Single point damage like fireballs also use this, since the area that does damage,
## is actually an area.

signal affectable_area_entered(area: AffectableArea)

# The collision layer is set to affectable areas so we know we only detect those.
# We then transmit our own signal to have a clearer type
func _on_area_entered(area: Area2D) -> void:
	affectable_area_entered.emit(area)
