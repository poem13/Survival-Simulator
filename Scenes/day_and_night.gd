extends StaticBody2D
#var state = "night"
onready var global_vars = get_node("/root/Global")
var change_state = true
var length_of_day = 15 #seconds
var length_of_night = 8 #seconds

func _ready():
	if global_vars.state == "day":
		$ColorRect.color.a = 0
	elif global_vars.state == "night":
		$ColorRect.color.a = 150

func _on_Timer_timeout():
	if global_vars.state == "day":
		global_vars.state = "night"
	elif global_vars.state == "night":
		global_vars.state = "day"
	
	change_state = true
	
func _process(delta):
	if change_state == true:
		change_state = false
		if global_vars.state == "day":
			change_to_day()
		elif global_vars.state == "night":
			change_to_night()

func change_to_day():
	$AnimationPlayer.play("nighttoday")
	$Timer.wait_time = length_of_day
	$Timer.start()

func change_to_night():
	$AnimationPlayer.play("daytonight")
	$Timer.wait_time = length_of_night
	$Timer.start()
