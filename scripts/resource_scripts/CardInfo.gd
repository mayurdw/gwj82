class_name CardInfo
extends RefCounted

@export var card_sprite: CardSprite

##
## If returns -1, throw error
func get_card_number() -> int:
	match card_sprite:
		CardSprite.ACE_CLUB, CardSprite.ACE_DIAMOND, CardSprite.ACE_HEART, CardSprite.ACE_SPADE: return 1
		CardSprite.TWO_DIAMOND, CardSprite.TWO_CLUB, CardSprite.TWO_HEART, CardSprite.TWO_SPADE: return 2
		CardSprite.THREE_CLUB, CardSprite.THREE_DIAMOND, CardSprite.THREE_HEART, CardSprite.THREE_SPADE: return 3
		CardSprite.FOUR_CLUB, CardSprite.FOUR_DIAMOND, CardSprite.FOUR_HEART, CardSprite.FOUR_SPADE: return 4
		CardSprite.FIVE_CLUB, CardSprite.FIVE_DIAMOND, CardSprite.FIVE_HEART, CardSprite.FIVE_SPADE: return 5
		CardSprite.SIX_CLUB, CardSprite.SIX_DIAMOND, CardSprite.SIX_HEART, CardSprite.SIX_SPADE: return 6
		CardSprite.SEVEN_CLUB, CardSprite.SEVEN_DIAMOND, CardSprite.SEVEN_HEART, CardSprite.SEVEN_SPADE: return 7
		CardSprite.EIGHT_CLUB, CardSprite.EIGHT_DIAMOND, CardSprite.EIGHT_HEART, CardSprite.EIGHT_SPADE: return 8
		CardSprite.NINE_CLUB, CardSprite.NINE_DIAMOND, CardSprite.NINE_HEART, CardSprite.NINE_SPADE: return 9
		CardSprite.TEN_CLUB, CardSprite.TEN_DIAMOND, CardSprite.TEN_HEART, CardSprite.TEN_SPADE: return 10
		CardSprite.JACK_CLUB, CardSprite.JACK_DIAMOND, CardSprite.JACK_HEART, CardSprite.JACK_SPADE: return 11
		CardSprite.QUEEN_CLUB, CardSprite.QUEEN_DIAMOND, CardSprite.QUEEN_HEART, CardSprite.QUEEN_SPADE: return 12
		CardSprite.KING_CLUB, CardSprite.KING_DIAMOND, CardSprite.KING_HEART, CardSprite.KING_SPADE: return 13
		_: return -1

func is_complete_match(cardInfo: CardInfo) -> bool:
	return cardInfo.card_sprite == card_sprite

func is_partial_match(cardInfo: CardInfo) -> bool:
	return cardInfo.get_card_number() == get_card_number()

# This is arranged in the order they are in the spreadsheet
enum CardSprite {
	QUEEN_CLUB = 0,
	FOUR_CLUB,
	EIGHT_HEART,
	ACE_DIAMOND,
	QUEEN_SPADE,
	FOUR_SPADE,
	KING_CLUB,
	THREE_CLUB,
	SEVEN_HEART,
	TEN_DIAMOND,
	KING_SPADE,
	THREE_SPADE,
	JACK_CLUB,
	TWO_CLUB,
	SIX_HEART,
	NINE_DIAMOND,
	JACK_SPADE,
	TWO_HEART,
	ACE_CLUB,
	FIVE_HEART = 20,
	EIGHT_DIAMOND,
	ACE_SPADE,
	TEN_CLUB = 24,
	QUEEN_HEART,
	FOUR_HEART,
	SEVEN_DIAMOND,
	TEN_SPADE,
	NINE_CLUB = 30,
	KING_HEART,
	THREE_HEART,
	SIX_DIAMOND,
	NINE_SPADE,
	EIGHT_CLUB = 36,
	JACK_HEART,
	TWO_SPADE,
	FIVE_DIAMOND,
	EIGHT_SPADE,
	SEVEN_CLUB = 42,
	ACE_HEART,
	QUEEN_DIAMOND,
	FOUR_DIAMOND,
	SEVEN_SPADE,
	SIX_CLUB = 48,
	TEN_HEART,
	KING_DIAMOND,
	THREE_DIAMOND,
	SIX_SPADE,
	FIVE_CLUB = 54,
	NINE_HEART,
	JACK_DIAMOND,
	TWO_DIAMOND,
	FIVE_SPADE
}
