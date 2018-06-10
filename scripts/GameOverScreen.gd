extends Node2D

onready var globals = get_node("/root/global")


func _ready():
	globals.reset_level()	
	get_node("txt_HighScore").text = str(globals.maxScore)
	set_process_input(true)
	pass

func _input(event):
	if(event.is_action_pressed("ui_page_up")):
		globals.go_to_scene("res://scenes/Menu.tscn")
	
	if(event.is_action_pressed("ui_cancel")):
		get_tree().quit()