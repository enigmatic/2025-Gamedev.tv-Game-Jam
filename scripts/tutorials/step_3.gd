extends Node

@onready var resetLabel:Label = $Reset

func _ready() -> void:
	resetLabel.text = "Reset Level: " + InputMap.action_get_events("Reset")[0].as_text()
