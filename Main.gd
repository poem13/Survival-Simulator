extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target = Vector2.ZERO
var coconut_entered = false
var near_coconut = false
var stop_random_night_dialogue = true
var player_pos

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

onready var global_vars = get_node("/root/Global")
onready var crafting_station: CraftingStation = $CraftingSystem
onready var pivot: Position2D = $Position2D

var inventory = {
	"res://Crafting/Items/IronIngot.json": 15,
	"res://Crafting/Items/Wood.json": 10,
	"res://Crafting/Items/sword.json": 1
}

var night_dialogue = [
	"Wow it's already dark out",
	"Night time now...",
	"Where did the day go?",
	"Time flies when you're surviving...",
	"",
	"",
	"Darkness..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data = file.get_var()
			file.close()
			$Player.position = player_data["player_pos"]
			print(player_data)
	print("data loaded")
	$Player/ViewportContainer/GUI/craft.set_text(JSON.print(inventory))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		craft_item()

func craft_item():
	var items_and_inventory := crafting_station.craft(get_dict_from_json("res://Crafting/Items/sword.json"), inventory, 1)
	if(items_and_inventory.empty()):
		print("INSUFFICIENT RESOURCES")
		return
	inventory = items_and_inventory.inventory
	pivot.add_child(items_and_inventory.items[0])
	$Player/ViewportContainer/GUI/craft.set_text(JSON.print(inventory))
	print("Crafted item!")
	
func get_dict_from_json(path: String) -> Dictionary:
	var file = File.new()
	file.open(path, file.READ)
	var item = JSON.parse(file.get_as_text()).result
	file.close()
	return item
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_pos = $Player.position
	var mouse_position = get_global_mouse_position()
	var mouse_x = mouse_position.x
	var mouse_y = mouse_position.y
	if near_coconut == true:
		if Input.is_action_pressed("rightclick"):
			print("right clicked")
			$Node2D/contextMenu.show()
			$Node2D/contextMenu.set_global_position(Vector2(mouse_x, mouse_y))
		#if Input.is_action_pressed("rightclick"):
		#$Node2D/contextMenu.hide()
	if global_vars.state == "night":
		if stop_random_night_dialogue == true:
			talk(pick_night_dialogue())
			stop_random_night_dialogue = false
	if global_vars.state == "day":
		stop_random_night_dialogue = true

func pick_night_dialogue():
	night_dialogue.shuffle()
	var random_night_dialogue = night_dialogue[0]
	return random_night_dialogue
		
func collision():
	print("collided")

func talk(dialogue: String):
	$Player/Thoughts.show()
	$Player/Thoughts.text = dialogue
	yield(get_tree().create_timer(3), "timeout")
	$Player/Thoughts.hide()	

func _on_exitButton_pressed():
	$Node2D/contextMenu.hide()


func _on_mouse_entered():
	print("entered")
	return true


func _on_Area2D_mouse_entered():
	print("mouse on shape!")
	coconut_entered = true


func _on_Area2D_mouse_exited():
	coconut_entered = false


func _on_viewButton_pressed():
	talk("Just a regular coconut")


func _on_eatButton_pressed():
	$Node2D/contextMenu.hide()
	if $Player.hunger > 450:
		talk("Not really hungry right now")
	else:
		$coconut.hide()
		$Player.hunger += 100
		talk("Mmm...refreshing!")







func _on_nearArea_area_entered(area):
	print("near coconut")
	if area.name == "playerArea":
		print("near coconut TRUE")
		near_coconut = true


func _on_nearArea_area_exited(area):
	print("left coconut")
	if area.name == "playerArea":
		print("near coconut FALSE")
		near_coconut = false
		$Node2D/contextMenu.hide()


func _on_SaveButton_pressed():
	global_vars.scene = get_tree().current_scene.filename
	var data = {
		"hair" : global_vars.hair,
		"eyes" : global_vars.eyes,
		"body" : global_vars.body,
		"scene": global_vars.scene,
		"player_pos": player_pos,
	}
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	var file = File.new()
	#you can encrypt file with file.open_encrypted_with_pass below (ADD THIRD PARAMETER "password")
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()
	print("data saved")


func _on_LoadButton_pressed():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data = file.get_var()
			file.close()
			$Player.position = player_data["player_pos"]
			print(player_data)
	print("data loaded")


func _on_MenuButton_pressed():
	SceneChanger.change_scene('res://MainMenu.tscn', 'fade')
