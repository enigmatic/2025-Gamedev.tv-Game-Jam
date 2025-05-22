extends Node

@onready var moveLabel:Label = $Move
@onready var jumpLabel:Label = $Jump

func _ready() -> void:
	moveLabel.text = "Move Right: " + InputMap.action_get_events("Right")[0].as_text()
	jumpLabel.text = "Jump: " + InputMap.action_get_events("Jump")[0].as_text()
