extends Control


@onready var progress_bar: ProgressBar = $Portrait/XpBar/ProgressBar
@onready var xp_value: Label = $Portrait/XpBar/XpValue
@onready var level_value: Label = $LevelValue


func _ready() -> void:
	TheWitchManager.xp_updated.connect(_on_the_witch_xp_updated)
	_on_the_witch_xp_updated(TheWitchManager.get_xp())
	TheWitchManager.lvl_updated.connect(_on_the_witch_lvl_updated)
	_on_the_witch_lvl_updated(TheWitchManager.get_lvl())
	

func _on_the_witch_xp_updated(xp: int) -> void:
	progress_bar.max_value = TheWitchManager.get_xp_to_reach_next_lvl()
	progress_bar.value = xp
	xp_value.text = str(xp) + " / " + str(TheWitchManager.get_xp_to_reach_next_lvl())


func _on_the_witch_lvl_updated(lvl: int) -> void:
	level_value.text = str(lvl)
