extends Control

@onready var option_menu: TabContainer = $"../Settings"
@onready var credits_menu: Credits = $"../Credits"

func _ready():
	$VBoxContainer/Start.grab_focus()

func reset_focus():
	$VBoxContainer/Start.grab_focus()

func _on_start_pressed():
	Utilities.switch_scene("GDTVGame", self)
	AudioManager.play_music_sound()

func _on_option_pressed():
	option_menu.show()
	option_menu.reset_focus()
	AudioManager.play_button_sound()

func _on_credits_pressed():
	credits_menu.show();
	credits_menu.reset();
	AudioManager.play_button_sound();

func _on_quit_pressed():
	get_tree().quit()
