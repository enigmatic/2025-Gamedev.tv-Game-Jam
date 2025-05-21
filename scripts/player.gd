extends Node

@onready var _character:CharacterBody2D = self.get_parent();

func _input(event : InputEvent):
	if event.is_action_pressed("Jump"):
		_character.jump();
	if event.is_action_released("Jump"):
		_character.stop_jump();
		
func _process(_delta: float):
	_character.run(Input.get_axis("Left", "Right"));
	if (!_character.alive && _character.velocity.length_squared() == 0):
		Global.playerDied();
		self.set_process(false);

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if (body is Enemy):
		_character.kill();
