extends Node

# Sprites
var pepperoni = preload("res://assets/silami.png")
var green_pepper = preload("res://assets/green_pepper.png")
var red_pepper = preload("res://assets/red_pepper.png")
var yellow_pepper = preload("res://assets/yellow_pepper.png")
var bacon = preload("res://assets/bacon.png")
var bluefish = preload("res://assets/bluefish.png")
var yellowfish = preload("res://assets/yellowfish.png")
var mushroom = preload("res://assets/mushroom.png")
var pineapple = preload("res://assets/pineapple.png")
var tomato = preload("res://assets/tomato.png")

# Board constants
const MIN_X = 120
const MAX_X = 1260
const MIN_Y = 160
const MAX_Y = 700

# Difficulty variables
const MAX_LEVEL = 18
var level = 1
var numberOfToppings = level + 1
var ingredientsAvailable = level
var ingredients = [pepperoni, green_pepper, mushroom, bacon, red_pepper, yellow_pepper, pineapple, tomato, bluefish, yellowfish]

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
	current_scene = root.get_child( root.get_child_count() - 1)
	randomize()
	initialize_toppings(numberOfToppings)

func initialize_toppings(n):
	for i in range(0, n):
		var tmpType = randi(0) % ingredientsAvailable
		var tmp2DVector = Vector2(rand_range(MIN_X, MAX_X), rand_range(MIN_Y, MAX_Y))
		toppingsOnPizza[i] = {"type": tmpType, "pos": tmp2DVector}

func reset_level():
	level = 1
	numberOfToppings = level + 1
	ingredientsAvailable = (level + 2) / 2
	remainingToppings = numberOfToppings
	toppingsOnPizza = {}
	toppingsPlayerPlaced = {}
	initialize_toppings(numberOfToppings)
	totalScore = 0

func level_up():
	level += 1
	if(level >= MAX_LEVEL): level = MAX_LEVEL
	ingredientsAvailable = (level + 2) / 2
	numberOfToppings = level + 1
	remainingToppings = numberOfToppings
	toppingsOnPizza = {}
	toppingsPlayerPlaced = {}
	initialize_toppings(numberOfToppings)

func go_to_scene(path):
	#var previous_scene = current_scene
	# Load new scene
	#var s = ResourceLoader.load(path)
	
	# Instance the new scene
	#current_scene = s.instance()
	
	# Add it to the active scene, as child of root
	#get_tree().get_root().add_child(current_scene)
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	#get_tree().set_current_scene( current_scene )
	get_tree().change_scene(path)
	#previous_scene.queue_free()