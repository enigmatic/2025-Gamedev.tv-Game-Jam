extends CharacterBody2D

class_name Enemy

@export var bounceHeight: float = 1.0

var alive = true;
var _jump_velocity: float;

func _ready() -> void:
	bounceHeight *= Global.ppt;
	var default_gravity = ProjectSettings.get_setting("physics/2d/default_gravity");
	_jump_velocity = sqrt(bounceHeight * default_gravity * 2) * -1


func kill():
	alive = false;
	
func bounce_character(myChar: Character):
	myChar.velocity.y = _jump_velocity;
	
