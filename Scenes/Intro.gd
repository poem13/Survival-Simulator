extends Node2D

var target = Vector2.ZERO
var coconut_entered = false
var near_boy = false
var near_pool = false
var near_niko = false
var mouse_on_boy = true
var player_pos


var talkedToCrewboy = 0
var shake_amount = 0.3
onready var global_vars = get_node("/root/Global")
const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.file_exists(save_path) && global_vars.loaded == true:
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data = file.get_var()
			file.close()
			$Player.position = player_data["player_pos"]
			global_vars.hair = player_data["hair"]
			global_vars.eyes = player_data["eyes"]
			global_vars.body = player_data["body"]
			print(player_data)
	print("data loaded")	
	var tut = Dialogic.start('intro/tutorial')
	add_child(tut)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_pos = $Player.position
	get_node("Player/Camera2D").set_offset(Vector2( \
		rand_range(-1.0, 1.0) * shake_amount, \
		rand_range(-1.0, 1.0) * shake_amount \
	))
	
	var mouse_position = get_global_mouse_position()
	var space = $crewboy/nearBoy
	var mouse_x = mouse_position.x
	var mouse_y = mouse_position.y
	if near_pool == true && Input.is_action_pressed("rightclick"):
		print("right clicked")
		$Node2D/poolMenu.show()
		$Node2D/poolMenu.set_global_position(Vector2(mouse_x, mouse_y))			
	if near_boy == true && Input.is_action_pressed("rightclick"):
		if mouse_on_boy == true:
			print("right clicked")
			$Node2D/contextMenu.show()
			$Node2D/contextMenu.set_global_position(Vector2(mouse_x, mouse_y))
	if near_niko == true && Input.is_action_pressed("rightclick"):
		$Node2D/nikoMenu.show()
		$Node2D/nikoMenu.set_global_position(Vector2(mouse_x, mouse_y))


func _on_nearBoy_area_entered(area):
	print("near boy")
	if area.name == "playerArea":
		print("near boy TRUE")
		near_boy = true


func _on_nearBoy_area_exited(area):
	print("left boy")
	if area.name == "playerArea":
		print("near boy FALSE")
		near_boy = false
		$Node2D/contextMenu.hide()



func _on_RichTextLabel_mouse_entered():
	print("mouse near boy")
	near_boy = true


func _on_RichTextLabel_mouse_exited():
	print("mouse left boy")
	near_boy = false


func _on_exitButton_pressed():
	$Node2D/contextMenu.hide()


func _on_viewButton_pressed():
	$Node2D/contextMenu.hide()
	$Player/Thoughts.show()
	$Player/Thoughts.text = "One of the crew members in the ship"
	yield(get_tree().create_timer(3), "timeout")
	$Player/Thoughts.hide()


func _on_talkButton_pressed():
	match(talkedToCrewboy):
		0:
			var dialog1 = Dialogic.start('intro/introCrewboy')
			add_child(dialog1)
			talkedToCrewboy += 1
		1:
			if global_vars.hair == 4:
				var dialog4 = Dialogic.start('intro/introCrewboy4')
				add_child(dialog4)
			else:
				var dialog2 = Dialogic.start('intro/introCrewboy2')
				add_child(dialog2)
			talkedToCrewboy += 1
		2:
			var dialog3 = Dialogic.start('intro/introCrewboy3')
			add_child(dialog3)


func _on_pool_mouse_entered():
	print("mouse near pool")
	near_pool = true


func _on_pool_mouse_exited():
	near_pool = false


func _on_exitButton2_pressed():
	$Node2D/poolMenu.hide()


func _on_viewButtonPool_pressed():
	$Node2D/poolMenu.hide()
	$Player/Thoughts.show()
	$Player/Thoughts.text = "A pool that obviously can't be used right now."
	yield(get_tree().create_timer(3), "timeout")
	$Player/Thoughts.hide()


func _on_touchButton_pressed():
	$Node2D/poolMenu.hide()
	$Player/Thoughts.show()
	$Player/Thoughts.text = "Feels...cold"
	yield(get_tree().create_timer(3), "timeout")
	$Player/Thoughts.hide()


func _on_swimButton_pressed():
	var warn = Dialogic.start('intro/swimPool')
	add_child(warn)


func _on_niko_mouse_entered():
	near_niko = true


func _on_niko_mouse_exited():
	near_niko = false


func _on_viewNiko_pressed():
	$Node2D/nikoMenu.hide()
	$Player/Thoughts.show()
	$Player/Thoughts.text = "An older man chilling at the top deck..."
	yield(get_tree().create_timer(3), "timeout")
	$Player/Thoughts.hide()


func _on_exitNiko_pressed():
	$Node2D/nikoMenu.hide()


func _on_talkNiko_pressed():
	var niko1 = Dialogic.start('intro/niko1')
	add_child(niko1)
		


func _on_enter_area_entered(area):
	var popup = Dialogic.start('intro/popup')
	add_child(popup)


func _on_QuitButton_pressed():
	get_tree().quit()


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
