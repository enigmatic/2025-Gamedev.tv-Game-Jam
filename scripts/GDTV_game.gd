extends Node2D

@onready var ui_layer: CanvasLayer = $CanvasLayer
@onready var reset_layer: CanvasLayer = $ResetScreen
@onready var settings: TabContainer = $CanvasLayer/Panel/Settings

var levelLoaded = false;
'''
Flow chart
Game <==> Pause Menu ==> Settings
'''

func _ready():
	if !Global.player_died.is_connected(_on_player_die):
		Global.player_died.connect(_on_player_die)
		
	if !Utilities.level_loaded.is_connected(_on_level_loaded):
		Utilities.level_loaded.connect(_on_level_loaded)
		
	if (!levelLoaded):
		reset_layer.visible = false;
		Utilities.loadLevel(0);
		levelLoaded = true;
	resume_game();

func _input(event: InputEvent):
	if event.is_action_pressed("Escape"):
		if not ui_layer.visible:
			show_ui_layer()
		else:
			resume_game()

func show_ui_layer():
	pause_game()
	ui_layer.show()
	reset_focus()

func reset_focus():
	$CanvasLayer/Panel/PauseMenu/Resume.grab_focus()

func pause_game():
	Engine.time_scale = 0

func resume_game():
	Engine.time_scale = 1
	settings.hide()
	ui_layer.hide()

func _on_resume_pressed():
	resume_game()

func _on_option_pressed():
	settings.show()
	settings.reset_focus()

func _on_main_menu_pressed():
	Utilities.switch_scene("MainMenu", self)

func _on_player_die():
	reset_layer.visible = true;

func _on_restart_pressed() -> void:
	Utilities.reloadLevel()

func _on_level_loaded() -> void:
	reset_layer.visible = false;
