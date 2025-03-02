extends Node2D

var battleScene = preload("res://Scenes/battle_scene.tscn")
var textScene = preload("res://Scenes/text_scene.tscn")

func _ready():
	initiateText("res://TextFiles/critterDialouge1.json")

func initiateBattle(enemyList : Array, reset : bool, nextTextPath : String):
	for i in range(get_child_count()):
		get_child(i).queue_free()
		remove_child(get_child(i))
	for i in range(EnemyParty.size):
		EnemyParty.removeCharacter(0)
	for i in range(enemyList.size()):
		var newEnemy = load(enemyList[i])
		var newEnemyInstance = newEnemy.instantiate()
		print(newEnemyInstance.characterName)
		EnemyParty.addCharacter(newEnemyInstance)
		print(EnemyParty.getCharacter(0).characterName + " : " + str(EnemyParty.size))
	var battleSceneInstance = battleScene.instantiate()
	battleSceneInstance.reset = reset
	battleSceneInstance.nextTextPath = nextTextPath
	add_child(battleSceneInstance)

func initiateText(dialougePath : String):
	for i in range(get_child_count()):
		get_child(i).queue_free()
		remove_child(get_child(i))
	var textSceneInstance = textScene.instantiate()
	textSceneInstance.dialougePath = dialougePath
	add_child(textSceneInstance)

func inititateTitle():
	pass

func initiateLose():
	pass

func initiateEnd():
	pass
