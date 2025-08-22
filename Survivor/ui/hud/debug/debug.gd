extends Control

@onready var debug: RichTextLabel = $Content/DebugText
@onready var content: Control = $Content


func _ready() -> void:
	content.hide()
	

func _on_xp_curve_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		debug.text = ""
		debug.show()
		var max_lvl = 100
		var count = 1
		
		while count <= max_lvl:
			debug.text += "\n " + str(count) + " : " + str(TheWitchManager._xp_to_reach_lvl(count)) + " xp"
			count += 1
			
	else:
		debug.hide()


func _on_open_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		content.show()
	else:
		content.hide()
		TheWitchManager.xp_received.disconnect(_on_xp_received)
		

func _on_xp_monitor_toggled(toggled_on: bool) -> void:
	if toggled_on:
		debug.text = ""
		TheWitchManager.xp_received.connect(_on_xp_received)
	else:
		TheWitchManager.xp_received.disconnect(_on_xp_received)
	

func _on_xp_received(amount: int) -> void:
	debug.text += "\n XP received: " + str(amount)
