extends Node2D
export var Main : PackedScene

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"
onready var global_vars = get_node("/root/Global")

func _ready():
	var file = File.new()
	if file.file_exists(save_path):
		$MarginContainer/VBoxContainer/VBoxContainer/MarginContainer4.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_Game_Button_button_up():
	#SceneChanger.change_scene('res://Scenes/Customizer.tscn', 'fade')
	get_tree().change_scene('res://Scenes/Customizer.tscn')	


func _on_Options_Button_pressed():
	$Label.show()


func _on_Load_Button_pressed():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data = file.get_var()
			file.close()
			global_vars.loaded = true
			SceneChanger.change_scene(player_data["scene"], 'fade')
			print(player_data)
	print("data loaded")
