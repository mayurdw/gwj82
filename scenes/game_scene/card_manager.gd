class_name Card
extends Node

@export var level_info: LevelInfo
@onready var container: HBoxContainer = $HBoxContainer
@onready var card_scene := preload("res://scenes/game_scene/components/card.tscn")

var _card_to_match_index: int = -1

signal correct_card(score: int)
signal incorrect_card(score: int)
signal level_won

func ready_cards() -> void:
	for n in level_info.card_families.size():
		var scene = card_scene.instantiate()
		scene.card_number = level_info.card_numbers[n]
		scene.card_family = level_info.card_families[n]
		scene.connect("card_revealed", _card_revealed)
		container.add_child(scene)

func _get_index(index_to_search: int) -> int:
	for n in container.get_children().size():
		if index_to_search == container.get_child(n).unique_id:
			return n
	
	return -1

func _is_match(current_index : int, index_to_match: int) -> bool:
	return level_info.card_families[current_index] == level_info.card_families[index_to_match] and _is_partial_match(current_index, index_to_match)

func _is_partial_match(current_index : int, index_to_match: int) -> bool:
	return level_info.card_numbers[current_index] == level_info.card_numbers[index_to_match]

func display_cards() -> void:
	for n in container.get_children().size():
		container.get_child(n).display_card()

func activate_cards() -> void:
	for n in container.get_children().size():
		container.get_child(n).activate_card()

func _check_win_condition() -> void:
	for n in container.get_children().size():
		if container.get_child(n).card_still_in_play:
			return
	
	level_won.emit()

func _card_revealed(revealed_card_info_id: int) -> void:
	var index = _get_index(revealed_card_info_id)
	print("Index found = %d" % index)
	if index == _card_to_match_index:
		print("Double Click, ignore")
	elif _card_to_match_index < 0:
		print("Setting new card index")
		_card_to_match_index = index
	elif _is_match(_card_to_match_index, index) or _is_partial_match(_card_to_match_index, index):
		print("Full Match")
		correct_card.emit(level_info.minimum_correct_score if _is_match(_card_to_match_index, index) else level_info.minimum_partial_match_score)
		container.get_child(index).reveal_card_with_animation(true)
		container.get_child(_card_to_match_index).reveal_card_with_animation(true)
		_card_to_match_index = -1
		_check_win_condition()
	else:
		print("No match")
		incorrect_card.emit(level_info.minimum_incorrect_score)
		container.get_child(index).reveal_card_with_animation(false)
		container.get_child(_card_to_match_index).reveal_card_with_animation(false)
		_card_to_match_index = -1
