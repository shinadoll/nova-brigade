extends Node

var turn = 0

func _ready():
	PlayerParty.partyDefeat.connect(exit)
	EnemyParty.partyDefeat.connect(exit)
	doTurn()

func doTurn():
	var characterList = getMoveOrder()
	print(characterList)
	for i in range(characterList.size()):
		var current = characterList[i]
		var index = await $Node.getMove
		current.useMove(index)
		# damageCalculation(damageData[0], damageData[1], damageData[2])
	#doTurn()

#return move order
func getMoveOrder():
	#initialize list
	var characterList = []
	for i in range(PlayerParty.size):
		characterList.append(PlayerParty.get_child(i))
	for i in range(EnemyParty.size):
		characterList.append(EnemyParty.get_child(i))
	for i in range(PlayerParty.size + EnemyParty.size - 1):
		var minIndex = i
		for j in range(i + 1, PlayerParty.size + EnemyParty.size):
			if characterList[j].stats["spd"] < characterList[minIndex].stats["spd"]:
				minIndex = j
		var temp = characterList[i]
		characterList[i] = characterList[minIndex]
		characterList[minIndex] = temp
	return characterList

func damageCalculation(actor : Character, target : Array, damage : int):
	for i in range(target.size()):
		var realDamage = (actor.stats["atk"] * damage) / (target[i].stats["hp"] * 5)
		target[i].stats["hp"] -= realDamage

func damageCheck():
	var count = 0
	for i in range(PlayerParty.size):
		var currentChild = get_child(i)
		if currentChild.stats["hp"] <= 0:
			currentChild.queue_free()
			count += 1
	if count == PlayerParty.size:
		pass
		#partyDefeat.emit()

func exit(partyType):
	match partyType: 
		"player": #player lose
			pass 
		"enemy": #enemy lose i.e. player win
			pass
