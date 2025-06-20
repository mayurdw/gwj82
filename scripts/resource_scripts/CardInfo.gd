class_name CardInfo
extends RefCounted

@export var cardNumber: CardNumber = CardNumber.ACE
@export var cardFamily: CardFamily = CardFamily.CLUB

func is_match(cardInfo: CardInfo) -> bool:
	return cardFamily == cardInfo.cardFamily and is_partial_match(cardInfo) 

func is_partial_match(cardInfo: CardInfo) -> bool:
	return cardNumber == cardInfo.cardNumber

func get_card_region() -> Rect2:
	return Rect2(cardNumber * 150, cardFamily * 200, 140.0, 190.0)

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
