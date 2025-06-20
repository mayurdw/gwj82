extends MarginContainer

@onready var coin_count: Label = $"HBoxContainer/CenterContainer/HBoxContainer/Coin Count"
@onready var timer: Timer = $Timer

var _coins: int = 100
var _target_coins: int = 100

func set_new_coins(new_value: int) -> void:
	timer.stop()
	_target_coins += new_value
	timer.start()

func _on_timer_timeout() -> void:
	coin_count.text = "x %d" % _coins
	if _target_coins == _coins:
		timer.stop()
	elif _target_coins < _coins:
		_coins -= 10
	else:
		_coins += 10
