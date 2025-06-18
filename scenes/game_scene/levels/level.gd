extends Node

signal level_won
signal level_lost

var level_state : LevelStateExample

func open_tutorials() -> void:
	%TutorialManager.open_tutorials()
	level_state.tutorial_read = true

func _ready() -> void:
	level_state = GameStateExample.get_level_state(scene_file_path)
	if not level_state.tutorial_read:
		open_tutorials()

func _on_tutorial_button_pressed() -> void:
	open_tutorials()

func _on_dice_button_pressed() -> void:
	pass # Replace with function body.
