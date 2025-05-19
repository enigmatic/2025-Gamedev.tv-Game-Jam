extends Node

@export var main_menu: PackedScene;

func _ready():
	$Back.grab_focus();

func _on_back_pressed():
	get_tree().change_scene_to_packed(main_menu)
	self.queue_free();
