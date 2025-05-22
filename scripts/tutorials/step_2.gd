extends Node

@onready var moveLabel:Label = $Move

func _ready() -> void:
	moveLabel.text = "Move Left: " + InputMap.action_get_events("Left")[0].as_text()
