extends Area2D

func _ready() -> void:
	connect("mouse_entered", entered)
	connect("mouse_exited", exited)

func entered() -> void:
	pass

func exited() -> void:
	pass
