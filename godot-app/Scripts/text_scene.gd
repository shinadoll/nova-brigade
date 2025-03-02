extends Node2D

var dialougePath : String
var lineIndex = 1
var cast : Array
var initialCastState : Array

@onready var nameLabel = $UI/NameLabel
@onready var textBox = $UI/TextBox

@onready var sprite1 = $Sprite1
@onready var sprite2 = $Sprite2
@onready var sprite3 = $Sprite3
@onready var sprite4 = $Sprite4

@onready var currentDialouge = loadText(dialougePath)

var characterImageFiles = {
	"Dizzy" : ["res://Assets/P1_sprite.png", "res://Assets/Alt_Sprites/P1_happy_sprite.png", "res://Assets/Alt_Sprites/P1_openmouth_sprite.png", "res://Assets/Alt_Sprites/P2_sad_sprite.png"],
	"Ashe" : ["res://Assets/P2_sprite.png", "res://Assets/Alt_Sprites/P2_happy_sprite.png", "res://Assets/Alt_Sprites/P2_openmouth_sprite.png", "res://Assets/Alt_Sprites/P2_sigh_sprite.png"],
	"Terra" : ["res://Assets/P3_sprite.png", "res://Assets/Alt_Sprites/P3_happy_sprite.png", "res://Assets/Alt_Sprites/P3_openmouth_sprite.png", "res://Assets/Alt_Sprites/P3_sad_sprite.png"],
	
	"Pibby" : ["res://Assets/CritterBoss_sprite.png", "res://Assets/critter_p2.png"],
	"Gilly" : ["res://Assets/WaterBoss_sprite.png", "res://Assets/Alt_Sprites/fish_openmouth_sprite.png", "res://Assets/Water_p2.png"],
	"COIL" : ["res://Assets/ComputerBoss_sprite.png", "res://Assets/computer_p2.png"],
	"Madeline" : ["res://Assets/NerdBoss_sprite.png", "res://Assets/nerd_p2.png"],
	"Lizbea" : ["res://Assets/FinalBoss_sprite.png", "res://Assets/Alt_Sprites/Boss_openmouth_sprite.png", "res://Assets/Alt_Sprites/Boss_sad_sprite.png", "res://Assets/final_p2.png"],
}

func _ready():
	cast = currentDialouge[0].cast
	initialCastState = currentDialouge[0].initialCastState
	sprite1.texture = load(characterImageFiles[cast[0]][initialCastState[0]])
	sprite2.texture = load(characterImageFiles[cast[1]][initialCastState[1]])
	sprite3.texture = load(characterImageFiles[cast[2]][initialCastState[2]])
	if initialCastState[3] != null:
		sprite4.texture = load(characterImageFiles[cast[3]][initialCastState[3]])
	nextLine()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if lineIndex < currentDialouge.size():
			nextLine()
		else:
			if currentDialouge[0].nextTextPath == null:
				get_parent().initiateEnd()
			elif currentDialouge[0].battleEnemies != null:
				get_parent().initiateBattle(currentDialouge[0].battleEnemies, currentDialouge[0].reset, currentDialouge[0].nextTextPath)
			else:
				print("next text")
				get_parent().initiateText(currentDialouge[0].nextTextPath)

func nextLine():
	nameLabel.text = currentDialouge[lineIndex].speaker
	textBox.text = currentDialouge[lineIndex].text
	if ("sfx" in currentDialouge[lineIndex]):
		print(currentDialouge[lineIndex].sfx)
	if ("blank" in currentDialouge[lineIndex]):
		pass

	sprite1.texture = load(characterImageFiles[cast[0]][currentDialouge[lineIndex].frame[0]])
	sprite2.texture = load(characterImageFiles[cast[1]][currentDialouge[lineIndex].frame[1]])
	sprite3.texture = load(characterImageFiles[cast[2]][currentDialouge[lineIndex].frame[2]])
	if currentDialouge[lineIndex].frame[3] != null:
		sprite4.texture = load(characterImageFiles[cast[3]][currentDialouge[lineIndex].frame[3]])
	lineIndex += 1

func loadText(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	var data = JSON.parse_string(content)
	return data
