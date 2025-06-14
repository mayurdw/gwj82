extends Area2D

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var card: Sprite2D = $PlayingCards
@onready var back: Sprite2D = $PlayingCardBacks
@onready var collider: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	connect("mouse_entered", make_focussed)
	connect("mouse_exited", leave_focussed)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		card_opened()

func make_focussed() -> void:
	# Focus Animation or Shader
	pass

func leave_focussed() -> void:
	# Reverse Focus Animation or Shader
	pass

func card_opened() -> void:
	# Fade the card back
	back.visible = false
	collider.disabled = true
