extends Area2D

@onready var animator: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	connect("mouse_entered", make_focussed)
	connect("mouse_exited", leave_focussed)

func make_focussed() -> void:
	animator.play("hover")

func leave_focussed() -> void:
	animator.play_backwards("hover")
