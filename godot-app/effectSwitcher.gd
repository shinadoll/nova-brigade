extends Node2D

var gun
var transubstantiate
var disentangle
var recombobulate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gun = get_node("./gun")
	transubstantiate = get_node("./transubstantiate")
	disentangle = get_node("./disentangle")
	recombobulate = get_node("./recombobulate")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func processAction(action):
	gun.hide()
	transubstantiate.hide()
	disentangle.hide()
	recombobulate.hide()
	
	match (action.shortName):
		"transubstantiate":
			transubstantiate.show()
		"disentangle":
			disentangle.show()
		"recombobulate":
			recombobulate.show()
		"gun":
			gun.show()
