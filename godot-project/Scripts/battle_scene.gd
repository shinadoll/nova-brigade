extends Node

var characterVisual = preload("res://Scenes/character_visual.tscn")
var nextTextPath : String
var reset : bool

@onready var timer = $Timer
@onready var textBox = $Label
@onready var moveTextBox = $MoveList

var turn = 0
func _ready():
	#set up character graphics
	for i in range(PlayerParty.size):
		for j in range(get_child_count()):
			var child = get_child(j)
			if child.is_in_group("CharacterVisual") and child.index == i:
				child.party = PlayerParty
				child.character = PlayerParty.getCharacter(i)
				child.loadTexture(PlayerParty.getCharacter(i).texture)
				
	for i in range(EnemyParty.size):
		for j in range(get_child_count()):
			var child = get_child(j)
			if child.is_in_group("CharacterVisual") and child.index == 3:
				child.party = EnemyParty
				child.character = EnemyParty.getCharacter(i)
				child.loadTexture(EnemyParty.getCharacter(i).texture)

	#reset stats
	if reset:
		for i in range(PlayerParty.size):
			PlayerParty.getCharacter(i).reset()
	for i in range(EnemyParty.size):
		EnemyParty.getCharacter(i).reset()
	doTurn()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("skip"):
		get_parent().initiateText(nextTextPath)

func doTurn():
	while true:
		textBox.text = ""
		turn += 1
		print("Turn : " + str(turn))
		var characterList = getMoveOrder()
		print(characterList)
		
		# ---   ---   ---
		#
		# code for connecting to next.js goes here
		#
		# ---   ---   ---
		
		for i in range(characterList.size()):
			print(EnemyParty.getCharacter(0).stats["hp"])
			var current = characterList[i]
			var index : int
			var nextAction : Action
			
			print(characterList[0].characterName + " : " + str(characterList[0].stats))
			print(characterList[1].characterName + " : " + str(characterList[1].stats))
			print(characterList[2].characterName + " : " + str(characterList[2].stats))
			print(characterList[3].characterName + " : " + str(characterList[3].stats))
			
			if current.stats["hp"] <= 0:
				continue
			
			#player party
			if current.get_parent() == PlayerParty:
				var moveListString = current.characterName + "HP : " + str(current.stats["hp"]) + "\n" + "1. " + current.getMove(0).displayName + "\n" + "2. " + current.getMove(1).displayName + "\n" + "3. " + current.getMove(2).displayName + "\n" + "4. " + current.getMove(3).displayName + "\n"
				moveTextBox.text = moveListString
				index = await SignalTester.playerInput
				nextAction = current.getMove(index)
			
			#enemy party
			elif current.get_parent() == EnemyParty:
				index = randi_range(0, current.get_child_count() - 1)
				nextAction = current.getMove(index)
			
			var newTarget : Array
			match nextAction.targetType:
				nextAction.TARGET_TYPES.SINGLE_ALLY:
					newTarget = [PlayerParty.getCharacter(0)]
					for j in range(PlayerParty.size):
						if newTarget[0].stats["hp"] <= 0:
							newTarget = [PlayerParty.get_child(j)]
						if newTarget[0].stats[nextAction.stat] > PlayerParty.get_child(j).stats[nextAction.stat]:
							newTarget = [PlayerParty.get_child(j)]
				nextAction.TARGET_TYPES.SINGLE_ENEMY:
					newTarget = [EnemyParty.getCharacter(0)]
					for j in range(EnemyParty.size):
						if newTarget[0].stats[nextAction.stat] < EnemyParty.get_child(j).stats[nextAction.stat]:
							newTarget = [EnemyParty.get_child(j)]
				nextAction.TARGET_TYPES.PARTY_ALLY:
					newTarget = PlayerParty.get_children()
				nextAction.TARGET_TYPES.PARTY_ENEMY:
					newTarget = EnemyParty.get_children()
			nextAction.target = newTarget
			var realDamage = damageCalculation(nextAction.actor, nextAction.target, nextAction.stat, nextAction.value)
			
			var targetDescription : String
			if nextAction.actor == nextAction.target[0]:
				targetDescription = "themself"
			elif nextAction.target.size() == 1:
				targetDescription = nextAction.target[0].characterName
			var statDirection : String
			if nextAction.value < 0:
				statDirection = " increased!"
			elif nextAction.value > 0:
				statDirection = " decreased!"
			var statDescription : String
			if nextAction.stat == "hp" and nextAction.value > 0:
				statDirection = ""
				statDescription = str(realDamage) + " damage done!"
			else:
				statDescription = nextAction.stat.to_upper()
			textBox.text = nextAction.description + targetDescription + ". " + statDescription + statDirection
			
			if PlayerParty.isPartyDefeat():
				get_parent().initiateLose()
				return
			elif EnemyParty.isPartyDefeat():
				get_parent().initiateText(nextTextPath)
				return

			for j in range(get_child_count()):
				var child = get_child(j)
				if child.is_in_group("CharacterVisual"): 
					if child.character == current:
						child.startAnimation()
			timer.start()
			await timer.timeout

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
			if characterList[j].stats["spd"] > characterList[minIndex].stats["spd"]:
				minIndex = j
		var temp = characterList[i]
		characterList[i] = characterList[minIndex]
		characterList[minIndex] = temp
	return characterList

func damageCalculation(actor : Character, target : Array, stat: String, value : int):
	for i in range(target.size()):
		if stat == "hp" and value > 0:
			var realDamage = ((actor.stats["atk"] * value) + 1) / ((target[i].stats["def"] * 5 + 1))
			print("realDamage: " + str(realDamage))
			target[i].stats["hp"] -= realDamage
			if target[i].stats["hp"] <= 0:
				target[i].stats["hp"] = 0
			return realDamage
		elif stat == "hp":
			print("heal")
			print(value)
			if target[i].stats[stat] - value <= 0:
				target[i].stats[stat] = 0
			elif target[i].stats[stat] - value >= target[i].statsDefault[stat]:
				target[i].stats[stat] = target[i].statsDefault[stat]
			else:
				target[i].stats[stat] -= value
			return value
			
		else:
			if target[i].stats[stat] - value <= 0:
				target[i].stats[stat] = 0
			elif target[i].stats[stat] - value >= 30:
				target[i].stats[stat] = 30
			else:
				target[i].stats[stat] -= value
			return value
