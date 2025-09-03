class_name Spell extends Resource

@export var name_key: String
@export var description_key: String
@export var icon: Texture2D
@export var type: Enums.Elements
## Time before the spell can be casted again. In Seconds.
@export_range(0.06, 10.0, 0.01, "suffix:s") var cooldown: float = 1.0
@export var scene: PackedScene
