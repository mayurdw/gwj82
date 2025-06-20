extends AspectRatioContainer

#region: OnReadys
@onready var card: TextureRect = $PlayingCards
@onready var back: TextureRect = $PlayingCardBacks
@onready var emitter: GPUParticles2D = $Emitter
@onready var timer: Timer = $Timer
#endregion

#region: State Variable
var card_still_in_play = true
var cardInfo: CardInfo
#endregion

func _ready() -> void:
	if cardInfo == null:
		cardInfo = CardInfo.new()
	card.texture.region = cardInfo.get_card_region()

func change_focus(is_focussed: bool) -> void:
	back.material.set("shader_parameter/is_active", is_focussed)
	create_tween().tween_method(_update_radius, 0.1, 2.0, 0.5)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		reveal_card_with_animation(false)

func reveal_card_with_animation(is_match: bool) -> void:
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
