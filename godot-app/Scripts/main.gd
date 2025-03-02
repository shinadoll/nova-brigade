extends Node2D

var battleScene = preload("res://Scenes/battle_scene.tscn")
var textScene = preload("res://Scenes/text_scene.tscn")
var winScene = preload("res://Scenes/end_screen.tscn")
var loseScene = preload("res://Scenes/game_over_screen.tscn")
var startScene = preload("res://Scenes/start_screen.tscn")

func _ready():
	initiateTitle()

func initiateBattle(enemyList : Array, reset : bool, nextTextPath : String):
	GlobalAudio.set_stream(load("res://Assets/Train_fight.mp3"))
	GlobalAudio.play()
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
	GlobalAudio.set_stream(load("res://Assets/TrainSong_chill.mp3"))
	GlobalAudio.play()
	for i in range(get_child_count()):
		get_child(i).queue_free()
		remove_child(get_child(i))
	var textSceneInstance = textScene.instantiate()
	textSceneInstance.dialougePath = dialougePath
	add_child(textSceneInstance)

func initiateTitle():
	GlobalAudio.set_stream(load("res://Assets/TrainSong_chill.mp3"))
	GlobalAudio.play()
	for i in range(get_child_count()):
		get_child(i).queue_free()
		remove_child(get_child(i))
	var startSceneInstance = startScene.instantiate()
	add_child(startSceneInstance)

func initiateLose():
	for i in range(get_child_count()):
		get_child(i).queue_free()
		remove_child(get_child(i))
	var loseSceneInstance = loseScene.instantiate()
	add_child(loseSceneInstance)

func initiateEnd():
	for i in range(get_child_count()):
		get_child(i).queue_free()
		remove_child(get_child(i))
	var winSceneInstance = winScene.instantiate()
	add_child(winSceneInstance)
