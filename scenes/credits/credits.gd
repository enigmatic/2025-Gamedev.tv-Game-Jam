extends Credits

@export var pre_scene: Node

func _on_back_pressed() -> void:
	hide()
	pre_scene.reset_focus()
	AudioManager.play_button_sound()

func give_focus():
	$Back.grab_focus()
