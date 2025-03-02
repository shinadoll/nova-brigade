class_name Party
extends Node

@export var partyType : String

@export var size = 0
func addCharacter(character : Character):
	self.add_child(character)
	size += 1

func removeCharacter(index):
	if size > 0:
		self.get_child(index).queue_free()
		self.remove_child(self.get_child(index))
		size -= 1

func getCharacter(index):
	return get_child(index)

func statReset():
	for i in range(size):
		get_child(i).stats = get_child(i).statsStatic

func isPartyDefeat():
	var count = 0
	for i in range(size):
		if get_child(i).stats["hp"] <= 0:
			count += 1
	if count == size:
		return true
	else:
		return false
