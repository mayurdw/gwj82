extends Node

signal level_won
signal level_lost

@onready var timer: Timer = $Timer
@onready var time_display: Label = $"VBoxContainer/MarginContainer/HBoxContainer/Time Display"
@onready var card_manager: Card = $"VBoxContainer/Card Manager"
@onready var tutorial_manager: Node = %TutorialManager
@onready var hud: MarginContainer = $VBoxContainer/MarginContainer

var level_state : LevelStateExample
var _current_time := 0

@export var total_time := 5

func open_tutorials() -> void:
	%TutorialManager.open_tutorials()
	level_state.tutorial_read = true

func _ready() -> void:
	level_state = GameStateExample.get_level_state(scene_file_path)
	time_display.text = "00: 0%d" % total_time
	if not level_state.tutorial_read:
		open_tutorials()

func _on_tutorial_button_pressed() -> void:
	open_tutorials()

func _on_dice_button_pressed() -> void:
	pass # Replace with function body.


func _on_tutorial_manager_tutorial_completed() -> void:
	card_manager.ready_cards()
	card_manager.display_cards()
	timer.start()

func _on_timer_timeout() -> void:
	_current_time += 1
	if _current_time >= total_time:
		time_display.text = "00: 00"
		timer.stop()
		card_manager.activate_cards()
	else:
		time_display.text = "00: 0%d" % (total_time - _current_time)


func _on_card_manager_level_won() -> void:
	level_won.emit()


func _on_card_manager_correct_card(score: int) -> void:
	hud.set_new_coins(score)

func _on_card_manager_incorrect_card(score: int) -> void:
	hud.set_new_coins(score)
