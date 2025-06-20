extends AspectRatioContainer

#region: OnReadys
@onready var card: TextureRect = $PlayingCards
@onready var back: TextureRect = $PlayingCardBacks
@onready var emitter: GPUParticles2D = $Emitter
@onready var timer: Timer = $Timer
#endregion

#region: Exports
@export var card_number: LevelInfo.CardNumber = LevelInfo.CardNumber.ACE
@export var card_family: LevelInfo.CardFamily = LevelInfo.CardFamily.CLUB
#endregion

#region: Signal
signal card_revealed(unique_id: int)
#endregion

#region: State Variable
var card_still_in_play = true
var unique_id : int
#endregion

func _ready() -> void:
	unique_id = CardCounter.get_new_id()
	card.texture.region =  Rect2(card_number * 150, card_family * 200, 140.0, 190.0)

func change_focus(is_focussed: bool) -> void:
	back.material.set("shader_parameter/is_active", is_focussed)
	create_tween().tween_method(_update_radius, 0.1, 2.0, 0.5)

func display_card() -> void:
	back.visible = false

func _on_gui_input(event: InputEvent) -> void:
	if back.visible and event is InputEventMouseButton:
		display_card()
		card_revealed.emit(unique_id)

func reveal_card_with_animation(is_match: bool) -> void:
	if card_still_in_play:
		display_card()

		if is_match:
			emitter.emitting = true
			card_still_in_play = false
		else:
			card.material.set_shader_parameter("active", true)
			create_tween().tween_method(_incorrect_match, 90.0, 0.0, 0.25)
			timer.start()

func _update_radius(radius: float) -> void:
	back.material.set_shader_parameter("radius", radius)

func _incorrect_match(percentage: float) -> void:
	card.material.set_shader_parameter("intensity", percentage)

#region: Signal Callbacks
func _on_timer_timeout() -> void:
	back.visible = true
	card.material.set_shader_parameter("active", true)

func _on_mouse_entered() -> void:
	change_focus(true)

func _on_mouse_exited() -> void:
	change_focus(false)

func _on_focus_entered() -> void:
	change_focus(true)

func _on_focus_exited() -> void:
	change_focus(false)
#endregion
