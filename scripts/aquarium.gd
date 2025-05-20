extends Node2D

signal escaped;
signal outOfWater;
signal inWater;

func _on_goal_touched(body: Node2D):
	if body.is_in_group("Player"):
		Utilities.loadNextLevel();
		escaped.emit();


func _on_water_body_entered(body):
	if body.is_in_group("Player"):
		inWater.emit();


func _on_water_body_exited(body):
	if body.is_in_group("Player"):
		outOfWater.emit();
