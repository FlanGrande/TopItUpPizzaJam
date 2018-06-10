extends Node

onready var topping = preload("res://scenes/topping.tscn")
onready var globals = get_node("/root/global")
onready var txtLevel = get_node("txt_Level")
onready var txtToppings = get_node("txt_Toppings")
onready var txtScore = get_node("txt_Score")

const LOCKED_TIME = 240
var lock_time = LOCKED_TIME

func _ready():
	place_toppings()
	pass

func _process(delta):
	txtLevel.text = str(globals.level)
	txtToppings.text = str(globals.remainingToppings)
	txtScore.text = str(globals.totalScore)
	
	if(globals.remainingToppings == 0):
		lock_time -= 1
		
		if(lock_time <= 0):
			lock_time = LOCKED_TIME
			update_score()
			place_toppings()
			print('Level: ' + str(globals.level) + "    Score:" + str(globals.totalScore))
			print(globals.toppingsOnPizza)
			print(globals.toppingsPlayerPlaced)
	
	pass

func place_toppings():
	for i in range(0, globals.toppingsOnPizza.size()):
		var tmpTopping = topping.instance()
		tmpTopping.current_ingredient = globals.toppingsOnPizza[i].type
		tmpTopping.set_position(globals.toppingsOnPizza[i].pos)
		add_child(tmpTopping)

func update_score():
	for i in range(0, globals.toppingsPlayerPlaced.size()):
		var score = 0
		var baseScore = 500
		var closestToppingIndex = get_closest_topping_index(globals.toppingsPlayerPlaced[i])
		
		var distanceToClosestTopping = globals.toppingsOnPizza[closestToppingIndex].pos.distance_to(globals.toppingsPlayerPlaced[i].pos)
		
		if(globals.toppingsOnPizza[closestToppingIndex].type == globals.toppingsPlayerPlaced[i].type):
			score = int(baseScore - distanceToClosestTopping)
		else:
			score = -2000
		
		globals.toppingsOnPizza[closestToppingIndex].pos = Vector2(-10000, -10000) # This step is done to make the algorythm ignore already examined elements
		globals.totalScore += score
		
		if(globals.totalScore > globals.maxScore):
			globals.maxScore = globals.totalScore
		
		if(globals.totalScore < 0):
			globals.go_to_scene("res://scenes/GameOverScreen.tscn")
	
	globals.level_up()

func get_closest_topping_index(toppingFrom):
	var minimumDistance = globals.MAX_X * 2
	var minimumDistanceToppingIndex = 0
	
	for i in range(0, globals.toppingsOnPizza.size()):
		var tmpDistance = toppingFrom.pos.distance_to(globals.toppingsOnPizza[i].pos)
		
		if(tmpDistance < minimumDistance):
			minimumDistance = tmpDistance
			minimumDistanceToppingIndex = i
	
	return minimumDistanceToppingIndex
