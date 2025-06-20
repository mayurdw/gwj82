extends Node

var count = 0

func get_new_id() -> int:
	var id = count
	count += 1
	return id
