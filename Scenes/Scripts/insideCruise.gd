extends Node2D

var near_maria = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position = get_global_mouse_position()
	var mouse_x = mouse_position.x
	var mouse_y = mouse_position.y
	if near_maria == true && Input.is_action_pressed("rightclick"):
		print("right clicked")
		$contextMenu.show()
		$contextMenu.set_global_position(Vector2(mouse_x, mouse_y))		


func _on_mariatext_mouse_entered():
	near_maria = true



func _on_mariatext_mouse_exited():
	near_maria = false


func _on_viewButton_pressed():
	$contextMenu.hide()
	$Player/Thoughts.show()
	$Player/Thoughts.text = "Everyone's freaking out about this...especially that boy."
	yield(get_tree().create_timer(3), "timeout")
	$Player/Thoughts.hide()


func _on_closebutton_pressed():
	$contextMenu.hide()


func _on_talkButton_pressed():
	var maria = Dialogic.start('intro/maria1')
	add_child(maria)
