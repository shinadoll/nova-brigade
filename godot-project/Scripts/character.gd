class_name Character
extends Node


@export var characterName : String
@export var texture : CompressedTexture2D
var stats = {
	"hp" : 0,
	"mp" : 0,
	"atk" : 0,
	"def" : 0,
	"spd" : 0,
}

@export var statsDefault = {
	"hp" : 20,
	"mp" : 20,
	"atk" : 20,
	"def" : 20,
	"spd" : 20,
}

func setMove(newMove : Action):
	pass

func getMove(index):
	if index < get_child_count():
		return get_child(index)
	else:
		return null

func reset():
	stats = statsDefault
