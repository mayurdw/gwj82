class_name Card
extends Node

@export var level_info: LevelInfo
@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var card_scene := preload("res://scenes/game_scene/components/card.tscn")

var _card_to_match_index: int = -1

signal correct_card(score: int)
signal incorrect_card(score: int)

func _ready() -> void:
	for n in level_info.card_families.size():
		var scene = card_scene.instantiate()
		scene.card_number = level_info.card_numbers[n]
		scene.card_family = level_info.card_families[n]
		h_box_container.add_child(scene)

func _get_index(index_to_search: int) -> int:
	for n in level_info.card_numbers.size():
		if index_to_search == ((level_info.card_numbers[n] + 1) * (level_info.card_families[n] + 1)):
			return n
	
	return -1

func _is_match(current_index : int, index_to_match: int) -> bool:
	return level_info.card_families[current_index] == level_info.card_families[index_to_match] and _is_partial_match(current_index, index_to_match)

func _is_partial_match(current_index : int, index_to_match: int) -> bool:
	return level_info.card_numbers[current_index] == level_info.card_numbers[index_to_match]

func _card_revealed(revealed_card_info_id: int) -> void:
	var index = _get_index(revealed_card_info_id)
	if _card_to_match_index < 0:
		_card_to_match_index = index
	elif _is_match(_card_to_match_index, revealed_card_info_id):
		correct_card.emit(level_info.minimum_correct_score)
		h_box_container.get_child(index).reveal_card_with_animation(true)
		h_box_container.get_child(_card_to_match_index).reveal_card_with_animation(true)
	elif _is_partial_match(_card_to_match_index, revealed_card_info_id):
		correct_card.emit(level_info.minimum_partial_match_score)
		h_box_container.get_child(index).reveal_card_with_animation(true)
		h_box_container.get_child(_card_to_match_index).reveal_card_with_animation(true)
	else:
		incorrect_card.emit(level_info.minimum_incorrect_score)
		h_box_container.get_child(index).reveal_card_with_animation(false)
		h_box_container.get_child(_card_to_match_index).reveal_card_with_animation(false)
		_card_to_match_index = -1
