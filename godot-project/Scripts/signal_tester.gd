extends Node

signal playerInput(index)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		playerInput.emit(0)
	elif event.is_action_pressed("2"):
		playerInput.emit(1)
	elif event.is_action_pressed("3"):
		playerInput.emit(2)
	elif event.is_action_pressed("4"):
		playerInput.emit(3)
