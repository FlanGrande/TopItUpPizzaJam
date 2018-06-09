extends Node

onready var topping = preload("res://scenes/topping.tscn")
onready var globals = get_node("/root/global")

var update_log = 120


func _ready():
	place_toppings()
	pass

func _process(delta):
	if(globals.remainingToppings == 0):
		update_score()
		
	
	update_log -= 1
	
	if(update_log == 0):
		print('Level: ' + str(globals.level) + "    Score:" + str(globals.totalScore))
		update_log = 120
	
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
		
		if(globals.toppingsOnPizza[closestToppingIndex].type == globals.toppingsPlayerPlaced[closestToppingIndex].type):
			score = int(baseScore - distanceToClosestTopping * 2)
		else:
			score = -1000
		
		globals.toppingsOnPizza[closestToppingIndex].pos = Vector2(-10000, -10000) # This step is done to make the algorythm ignore already examined elements
		globals.totalScore += score
		
		if(globals.totalScore > globals.maxScore):
			globals.maxScore = globals.totalScore
	
	globals.level_up()
	place_toppings()

func get_closest_topping_index(toppingFrom):
	var minimumDistance = globals.MAX_X * 2
	var minimumDistanceToppingIndex = 0
	
	for i in range(0, globals.toppingsOnPizza.size()):
		var tmpDistance = toppingFrom.pos.distance_to(globals.toppingsOnPizza[i].pos)
		
		if(tmpDistance < minimumDistance):
			minimumDistance = tmpDistance
			minimumDistanceToppingIndex = i
	
	return minimumDistanceToppingIndex
