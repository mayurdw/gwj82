extends AspectRatioContainer

#region: OnReadys
@onready var card: TextureRect = $PlayingCards
@onready var back: TextureRect = $PlayingCardBacks
@onready var emitter: GPUParticles2D = $Emitter
@onready var timer: Timer = $Timer
#endregion

#region: State Variable
var card_still_in_play = true
@export var card_number: LevelInfo.CardNumber = LevelInfo.CardNumber.ACE
@export var card_family: LevelInfo.CardFamily = LevelInfo.CardFamily.CLUB
var unique_id
signal card_revealed(unique_id: int)
#endregion

func _ready() -> void:
	unique_id = CardCounter.get_new_id()
	card.texture.region = get_card_region()

func change_focus(is_focussed: bool) -> void:
	back.material.set("shader_parameter/is_active", is_focussed)
	create_tween().tween_method(_update_radius, 0.1, 2.0, 0.5)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		back.visible = false
		card_revealed.emit(unique_id)

func reveal_card_with_animation(is_match: bool) -> void:
	if card_still_in_play:
		back.visible = false
		disconnect("mouse_entered", _on_mouse_entered)
		disconnect("mouse_exited", _on_mouse_exited)
		disconnect("gui_input", _on_gui_input)

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
	connect("gui_input", _on_gui_input)

func _update_radius(radius: float) -> void:
	back.material.set_shader_parameter("radius", radius)

func update_radius(value: float):
	back.material.set_shader_parameter("radius", value)

func get_card_region() -> Rect2:
	return Rect2(card_number * 150, card_family * 200, 140.0, 190.0)

#region: Focus Signal Callbacks
func _on_mouse_entered() -> void:
	change_focus(true)

func _on_mouse_exited() -> void:
	change_focus(false)

func _on_focus_entered() -> void:
	change_focus(true)

func _on_focus_exited() -> void:
	change_focus(false)
#endregion
