extends Node2D

signal escaped;
signal outOfWater;
signal inWater;
@onready var outSplash:GPUParticles2D = $outSplash
@onready var inSplash:GPUParticles2D = $inSplash
@onready var splashSound: AudioStreamPlayer2D = $splash

func _on_goal_touched(body: Node2D):
	if body.is_in_group("Player"):
		Utilities.loadNextLevel();
		escaped.emit();


var skipFirst = true
func _on_water_body_entered(body):
	if skipFirst:
		skipFirst = false;
		return;
	inSplash.position.x = body.global_position.x
	inSplash.emitting = true;
	splashSound.play();
	if body.is_in_group("Player"):
		inWater.emit();


func _on_water_body_exited(body:Node2D):
	if (!body.alive):
		return;
	outSplash.position.x = body.global_position.x
	outSplash.emitting = true;
	splashSound.play();
	if body.is_in_group("Player"):
		outOfWater.emit();
