extends Node

signal getMove(index : int)

func _on_timer_timeout() -> void:
	getMove.emit(0)
