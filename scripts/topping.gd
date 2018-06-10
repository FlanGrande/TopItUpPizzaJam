extends Node2D

onready var globals = get_node("/root/global")

var fading_ratio = 0.02
var current_alpha = 1;

export var current_ingredient = 0

func _ready():
	get_node("ToppingSpr").set_texture(globals.ingredients[current_ingredient])
	change_anim("fade")
	pass

func change_anim(newanim):
	#If the animation is new,
	if (newanim != get_node("animationPlayer").get_current_animation()):
		get_node("animationPlayer").play(newanim) #Change it!