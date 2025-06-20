class_name LevelInfo
extends Resource

@export var card_families : Array[CardFamily]
@export var card_numbers : Array[CardNumber]
@export var minimum_correct_score : int = 100
@export var minimum_incorrect_score : int = -50
@export var minimum_partial_match_score : int = 75

func _init() -> void:
	assert(card_families.size() == card_numbers.size())

enum CardNumber {
	ACE = 0,
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	JACK,
	QUEEN,
	KING
}

enum CardFamily {
	CLUB = 0,
	SPADE,
	DIAMOND,
	HEART
}
