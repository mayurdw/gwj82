extends Control

@onready var roll_button: Button = $"HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Roll Button"
@onready var dice: TextureRect = $HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Panel/Dice

@export var duration: float = 3.0


func _get_region(side: int) -> Rect2:
	return Rect2((side - 1) * 80.0, 70.0, 68.0, 68.0)

func _roll_number() -> void:
	roll_button.disabled = true
	var tween = create_tween()

	tween.tween_method(_roll, 0.0, duration, randf_range(0.5, duration))
	await tween.finished
	print("Dice Roll = %d" %_get_roll())
	roll_button.disabled = false

func _roll(_side: int) -> void:
	dice.texture.region = _get_region(_get_roll())

func _get_roll() -> int:
	return randi_range(1, 6)
