class_name CharacterVisual
extends CharacterBody2D

@export var character : Character
@export var party : Party
@export var index : int

@onready var sprite = $Sprite2D
@onready var timer = $Timer
enum STATE {IDLE, BEGIN, END}
var state = STATE.IDLE

var beginVector : Vector2
var endVector : Vector2

func _ready():
	await get_parent().ready
	if party.partyType == "player":
		beginVector = Vector2(1,0) * 800
		endVector = -beginVector
	elif party.partyType == "enemy":
		beginVector = Vector2(-1,1).normalized() * 800
		endVector = -beginVector

func _process(_delta):
	match state:
		STATE.IDLE:
			return
		STATE.BEGIN:
			velocity = beginVector 
		STATE.END:
			velocity = endVector
	move_and_slide()

func startAnimation():
	state = STATE.BEGIN
	timer.start()

func loadTexture(texture):
	sprite.set("texture", texture)

func _on_timer_timeout() -> void:
	match state:
		STATE.BEGIN:
			state = STATE.END
			timer.start()
		STATE.END:
			state = STATE.IDLE
