extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global_vars = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and global_vars.paused == false:
		global_vars.paused = true
		get_tree().paused = true
		$pauseshader.show()
		$PauseMenu.show()
		print("paused")
	elif Input.is_action_just_pressed("ui_cancel") and global_vars.paused == true:
		global_vars.paused = false
		get_tree().paused = false
		$pauseshader.hide()
		$PauseMenu.hide()
		print("unpaused")


func _on_ResumeButton_pressed():
	global_vars.paused = false
	get_tree().paused = false
	$pauseshader.hide()
	$PauseMenu.hide()
	print("unpaused")
