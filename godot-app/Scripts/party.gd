class_name Party
extends Node

@export var partyType : String
signal partyDefeat(partyType)

@export var size = 0
var partyActive = 0
func addcharacter(character : Character):
	if size < 5:
		self.add_child(character)
		size += 1

func removeCharacter(index):
	if size > 0:
		self.remove_child(index)
		size -= 1

func getCharacter(index):
	return get_child(index)

func statReset():
	for i in range(size):
		get_child(i).stats = get_child(i).statsStatic

func isPartyDefeat():
	for i in range(size):
		if get_child(i).stats["hp"] <= 0:
			partyDefeat.emit()
