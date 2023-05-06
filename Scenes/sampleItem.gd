extends Node2D

func _ready():
	if randi()% 2 == 0:
		$TextureRect.texture = load("res://item_slots/axe.png")
	else:	
		$TextureRect.texture = load("res://item_slots/hoe.png")
