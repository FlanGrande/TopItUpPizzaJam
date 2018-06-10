extends Node2D

onready var globals = get_node("/root/global")
onready var Menu = get_node("text")
onready var HowToPlayText = get_node("HowToPlayText")
onready var CreditsText = get_node("CreditsText")
onready var Sprite1 = get_node("text/Play/Sprite")
onready var Sprite2 = get_node("text/Play/Sprite2")
onready var Sprite3 = get_node("text/HowToPlay/Sprite3")
onready var Sprite4 = get_node("text/HowToPlay/Sprite4")
onready var Sprite5 = get_node("text/Credits/Sprite5")
onready var Sprite6 = get_node("text/Credits/Sprite6")
onready var Sprite7 = get_node("text/Exit/Sprite7")
onready var Sprite8 = get_node("text/Exit/Sprite8")

const NUM_OPTIONS = 4
var selected_option = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	pass

func _input(event):
	if(Menu.visible):
		if(event.is_action_pressed("ui_down")):
			selected_option += 1
		
		if(event.is_action_pressed("ui_up")):
			selected_option -= 1
		
		if(event.is_action_pressed("ui_accept")):
			process_accept()
		
		if(selected_option >= NUM_OPTIONS):
			selected_option = 0
		
		if(selected_option < 0):
			selected_option = NUM_OPTIONS - 1
		
		Sprite1.visible = false
		Sprite2.visible = false
		Sprite3.visible = false
		Sprite4.visible = false
		Sprite5.visible = false
		Sprite6.visible = false
		Sprite7.visible = false
		Sprite8.visible = false
		
		if(selected_option == 0):
			Sprite1.visible = true
			Sprite2.visible = true
		
		if(selected_option == 1):
			Sprite3.visible = true
			Sprite4.visible = true
		
		if(selected_option == 2):
			Sprite5.visible = true
			Sprite6.visible = true
		
		if(selected_option == 3):
			Sprite7.visible = true
			Sprite8.visible = true
	
	if(!Menu.visible):
		if(event.is_action_pressed("ui_cancel")):
			Menu.visible = true
			HowToPlayText.visible = false
			CreditsText.visible = false


func process_accept():
	if(selected_option == 0):
		Menu.visible = false
		globals.go_to_scene("res://scenes/GameView.tscn")
	
	if(selected_option == 1):
		Menu.visible = false
		HowToPlayText.visible = true
	
	if(selected_option == 2):
		Menu.visible = false
		CreditsText.visible = true
	
	if(selected_option == 3):
		get_tree().quit()