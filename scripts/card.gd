extends Area2D

@onready var card: Sprite2D = $PlayingCards
@onready var back: Sprite2D = $PlayingCardBacks
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var emitter: GPUParticles2D = $Emitter
@onready var timer: Timer = $Timer

var card_still_in_play = true

var cardInfo: CardInfo

func _ready() -> void:
	if cardInfo == null:
		cardInfo = CardInfo.new()
		cardInfo.card_sprite = CardInfo.CardSprite.FOUR_SPADE
	card.frame = cardInfo.card_sprite

func change_focus(is_focussed: bool) -> void:
	back.material.set("shader_parameter/is_active", is_focussed)
	create_tween().tween_method(_update_radius, 0.1, 2.0, 0.5)

func _update_radius(radius: float) -> void:
	back.material.set_shader_parameter("radius", radius)

func update_radius(value: float):
	back.material.set_shader_parameter("radius", value)

func _on_mouse_entered() -> void:
	change_focus(true)

func _on_mouse_exited() -> void:
	change_focus(false)

func reveal_card_with_animation(is_match: bool) -> void:
	back.visible = false
	disconnect("mouse_entered", _on_mouse_entered)
	disconnect("mouse_exited", _on_mouse_exited)
	disconnect("input_event", _on_input_event)
	if is_match:
		emitter.emitting = true
		card_still_in_play = false
		# points signal? Maybe the manager should do this
	else:
		# Incorrect match animation?
		timer.start()


func _on_timer_timeout() -> void:
	back.visible = true
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("input_event", _on_input_event)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		reveal_card_with_animation(true)
