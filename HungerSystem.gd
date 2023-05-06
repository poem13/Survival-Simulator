extends Node2D

onready var timer = get_node("Timer")
onready var progress = get_node("Hunger")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = progress.value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress.value = timer.time_left
	$Label.text = str(progress.get_value())
