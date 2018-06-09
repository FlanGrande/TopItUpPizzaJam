extends Node

# Board constants
const MIN_X = 80
const MAX_X = 1360
const MIN_Y = 80
const MAX_Y = 800

# Difficulty variables
var level = 1
var numberOfToppings = level + 2

# Control variables
var toppingsOnPizza = {}
var toppingsPlayerPlaced = {}
var remainingToppings = numberOfToppings
var totalScore = 0
var maxScore = 0

# Scenes variables
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	randomize()
	initialize_toppings(numberOfToppings)

func initialize_toppings(n):
	for i in range(0, n):
		var tmpType = randi(0) % 2
		var tmp2DVector = Vector2(rand_range(MIN_X, MAX_X), rand_range(MIN_Y, MAX_Y))
		toppingsOnPizza[i] = {"type": tmpType, "pos": tmp2DVector}

func level_up():
	level += 1
	numberOfToppings = level + 2
	remainingToppings = numberOfToppings
	toppingsOnPizza = {}
	toppingsPlayerPlaced = {}
	initialize_toppings(numberOfToppings)