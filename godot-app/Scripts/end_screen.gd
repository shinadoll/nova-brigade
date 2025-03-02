extends Node2D

func _ready():
	for i in range(EnemyParty.size):
		EnemyParty.removeCharacter(i)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_parent().initiateTitle()
