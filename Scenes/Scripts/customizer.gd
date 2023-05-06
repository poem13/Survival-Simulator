extends Node


onready var body_tiles = $player/bodies
onready var eyes_tiles = $player/eyes
onready var outfit_tiles = $player/outfits
onready var hair_tiles = $player/hair

var outfit : int = 0
onready var global_vars = get_node("/root/Global")

func render_character():
	hair_tiles.set_cell(0, 1, global_vars.hair)
	eyes_tiles.set_cell(0, 1, global_vars.eyes)
	body_tiles.set_cell(0, 0, global_vars.body)
	outfit_tiles.set_cell(0, 0, outfit)

func _ready():
	render_character()

func _on_hair_button_pressed():
	global_vars.set_hair()
	render_character()
		
func _on_body_button_pressed():
	global_vars.set_body()
	render_character()

func _on_eyes_button_pressed():
	global_vars.set_eyes()
	render_character()

func _on_save_button_pressed():
	get_node("buttons").hide()
	get_node("player").hide()
	SceneChanger.change_scene("res://Scenes/Intro.tscn", "fade")



func _on_back_button_pressed():
	SceneChanger.change_scene("res://MainMenu.tscn", "fade")
