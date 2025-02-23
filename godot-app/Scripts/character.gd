class_name Character
extends Node

@export var characterName : String
var stats = {
	"hp" : 0,
	"mp" : 0,
	"atk" : 0,
	"def" : 0,
	"mAtk" : 0,
	"mDef" : 0,
	"spd" : 0,
	"lck" : 0,
}

@export var statsDefault = {
	"hp" : 0,
	"mp" : 0,
	"atk" : 0,
	"def" : 0,
	"mAtk" : 0,
	"mDef" : 0,
	"spd" : 0,
	"lck" : 0,
}

func useMove(index):
	get_child(index).perform()
