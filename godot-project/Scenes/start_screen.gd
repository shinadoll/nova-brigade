extends Node2D

func nextButton():
	$BG1.hide()
	
func startButton():
	get_parent().initiateText("res://TextFiles/critterDialouge1.json")
