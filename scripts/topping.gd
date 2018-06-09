extends Node2D

var pepperoni = preload("res://assets/pepperoni.jpg")
var green_pepper = preload("res://assets/green_pepper.jpg")

var fading_ratio = 0.02
var current_alpha = 1;
var ingredients = [pepperoni, green_pepper]

export var current_ingredient = 0

func _ready():
	get_node("ToppingSpr").set_texture(ingredients[current_ingredient])
	change_anim("fade")
	pass

func change_anim(newanim):
	#If the animation is new,
	if (newanim != get_node("animationPlayer").get_current_animation()):
		get_node("animationPlayer").play(newanim) #Change it!