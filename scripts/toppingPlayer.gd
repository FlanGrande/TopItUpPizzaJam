extends KinematicBody2D

onready var globals = get_node("/root/global")
onready var gameview = preload("res://scenes/GameView.tscn")
onready var topping = preload("res://scenes/topping.tscn")
var pepperoni = preload("res://assets/pepperoni.jpg")
var green_pepper = preload("res://assets/green_pepper.jpg")

# Player variables
const MOVEMENT_SPEED = 600
const ACCELERATION = 1
const DIAGONAL_FRICTION = 0.75
var speed = Vector2(0, 0)
var lock_time = 240

# Topping variables
var ingredients = [pepperoni, green_pepper]
export var current_ingredient = 0


func _ready():
	set_process(true)
	pass

func _process(delta):
	var x_movement = 0
	var y_movement = 0
	
	if(lock_time <= 0):
		move_and_slide(speed)
		
		if(Input.is_action_pressed("ui_left")):
			x_movement = -1
		
		if(Input.is_action_pressed("ui_right")):
			x_movement = 1
		
		if(Input.is_action_pressed("ui_up")):
			y_movement = -1
		
		if(Input.is_action_pressed("ui_down")):
			y_movement = 1
		
		if(Input.is_action_just_released("ui_accept")):
			place_topping()
		
	else:
		lock_time -= 1
	
	get_node("ToppingSpr").set_texture(ingredients[current_ingredient])
	
	if(Input.is_action_just_released("ui_page_up")):
		change_topping_up()
	
	if(Input.is_action_just_released("ui_page_down")):
		change_topping_down()
	
	x_movement *= MOVEMENT_SPEED
	y_movement *= MOVEMENT_SPEED
	
	if(abs(x_movement) >= MOVEMENT_SPEED && abs(y_movement) >= MOVEMENT_SPEED):
		x_movement = x_movement * DIAGONAL_FRICTION
		y_movement = y_movement * DIAGONAL_FRICTION
	
	speed.x = lerp(speed.x, x_movement, ACCELERATION)
	speed.y = lerp(speed.y, y_movement, ACCELERATION)

	pass

func place_topping():
	var tmpTopping = topping.instance()
	var tmpType = current_ingredient
	var tmp2DVector = get_position()
	tmpTopping.current_ingredient = tmpType
	tmpTopping.set_position(tmp2DVector)
	globals.toppingsPlayerPlaced[globals.numberOfToppings - globals.remainingToppings] = {"type": tmpType, "pos": tmp2DVector}
	globals.remainingToppings -= 1
	get_node("..").add_child(tmpTopping)
	
func change_topping_up():
	current_ingredient += 1
	if(current_ingredient >= ingredients.size()):
		current_ingredient = 0

func change_topping_down():
	current_ingredient -= 1
	if(current_ingredient < 0):
		current_ingredient = ingredients.size() - 1