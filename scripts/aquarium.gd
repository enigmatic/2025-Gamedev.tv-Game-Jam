extends Node2D

signal escaped;
signal outOfWater;
signal inWater;
@onready var outSplash:GPUParticles2D = $outSplash
@onready var inSplash:GPUParticles2D = $inSplash

func _on_goal_touched(body: Node2D):
	if body.is_in_group("Player"):
		Utilities.loadNextLevel();
		escaped.emit();


func _on_water_body_entered(body):
	inSplash.position.x = body.global_position.x
	inSplash.emitting = true;
	if body.is_in_group("Player"):
		inWater.emit();


func _on_water_body_exited(body:Node2D):
	outSplash.position.x = body.global_position.x
	outSplash.emitting = true;
	if body.is_in_group("Player"):
		outOfWater.emit();
