extends Node2D

signal escaped;

func _on_goal_touched(body: Node2D):
	if body.is_in_group("Player"):
		Utilities.loadNextLevel();
		escaped.emit();
