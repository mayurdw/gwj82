extends Area2D

@onready var card: Sprite2D = $PlayingCards
@onready var back: Sprite2D = $PlayingCardBacks
@onready var collider: CollisionShape2D = $CollisionShape2D

var card_still_in_play = true

var cardInfo: CardInfo

func _ready() -> void:
	if cardInfo == null:
		cardInfo = CardInfo.new()
		cardInfo.card_sprite = CardInfo.CardSprite.FOUR_SPADE
	card.frame = cardInfo.card_sprite

func change_focus(is_focussed: bool) -> void:
	back.material.set("shader_parameter/is_active", is_focussed)

func update_radius(value: float):
	back.material.set_shader_parameter("radius", value)

func _on_mouse_entered() -> void:
	change_focus(true)

func _on_mouse_exited() -> void:
	change_focus(false)

func set_card_complete() -> void:
	card_still_in_play = false
	disconnect("mouse_entered", _on_mouse_entered)
	disconnect("mouse_exited", _on_mouse_exited)
