extends KinematicBody2D

var health = 100
var hunger = 500
var damage = 0.01
var hunger_level = 10
const SPEED = 100
var velocity = Vector2.ZERO

onready var animatedSprite = $AnimatedSprite
onready var top = $AnimatedSprite/top
onready var pants = $AnimatedSprite/pants
onready var shoes = $AnimatedSprite/shoes
onready var eyes = $AnimatedSprite/eyes
onready var hair = $AnimatedSprite/hair

onready var global_vars = get_node("/root/Global")


# Called when the node enters the scene tree for the first time.
func _ready():
	top.play("idle")
	pants.play("idle")
	shoes.play("idle")
	get_idle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		velocity.y = 0
		animatedSprite.flip_h = false
		top.flip_h = false
		pants.flip_h = false
		shoes.flip_h = false
		eyes.flip_h = false
		hair.flip_h = false
		animatedSprite.play(get_walk_right())
		eyes.play(eye_walk_right())
		hair.play(get_hair_right())
		top.play("walk_right")
		pants.play("walk_right")
		shoes.play("walk_right")
		move_and_slide(velocity)
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		velocity.y = 0
		animatedSprite.flip_h = true
		top.flip_h = true
		pants.flip_h = true
		shoes.flip_h = true
		eyes.flip_h = true
		hair.flip_h = true
		animatedSprite.play(get_walk_right())
		eyes.play(eye_walk_right())
		hair.play(get_hair_right())
		top.play("walk_right")
		pants.play("walk_right")
		shoes.play("walk_right")
		eyes.play(eye_walk_right())
		move_and_slide(velocity)				
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
		velocity.x = 0
		move_and_slide(velocity)
		top.play("up")
		pants.play("up")
		shoes.play("up")
		animatedSprite.play(get_walk_up())
		hair.play(get_hair_up())
		eyes.play("none")
	elif Input.is_action_pressed("ui_down"):
		eyes.play(get_eyes_down())
		velocity.y = SPEED
		velocity.x = 0
		move_and_slide(velocity)
		top.animation = "down"
		pants.animation = "down"
		shoes.animation = "down"
		animatedSprite.play(get_walk_down())
		hair.play(get_hair_down())
	else:
		if velocity.x > 0:
			animatedSprite.flip_h = false
			top.flip_h = false
			pants.flip_h = false
			shoes.flip_h = false
			top.animation = "idle_right"
			pants.animation = "idle_right"
			shoes.animation = "idle_right"
			get_idle_right()
			hair.play(get_hair_idle_right())
		elif velocity.x < 0:
			animatedSprite.flip_h = true
			top.flip_h = true
			pants.flip_h = true
			shoes.flip_h = true
			top.animation = "idle_right"
			pants.animation = "idle_right"
			shoes.animation = "idle_right"
			get_idle_right()
			hair.play(get_hair_idle_right())
		elif velocity.y < 0:
			top.animation = "idle_up"
			pants.animation = "idle_up"
			shoes.animation = "idle_up"
			get_idle_up()
		else:	
			top.animation = "idle"
			pants.animation = "idle"
			shoes.animation = "idle"
			get_idle()		



func get_walk_up():
		match(global_vars.body):
			0:
				return "body1_up"
			1:
				return "body2_up"
			2:
				return "body3_up"
			3:
				return "body4_up"
			4:
				return "body5_up"	
				
func get_hair_up():										
		match(global_vars.hair):
			1:
				return "hair2_walkup"	
			2:
				return "hair3_walkup"		
			3:
				return "hair4_walkup"
			4:
				return "hair5_walkup"
			5:
				return "hair6_walkup"	
			6:
				return "hair7_walkup"
			7:
				return "hair8_walkup"
			8:
				return "hair1_walkup"				
				
				
				
				
func get_idle():
		match(global_vars.body):
			0:
				animatedSprite.animation = "body1_idle"	
			1:
				animatedSprite.animation = "body2_idle"		
			2:
				animatedSprite.animation = "body3_idle"
			3:
				animatedSprite.animation = "body4_idle"
			4:
				animatedSprite.animation = "body5_idle"			
		match(global_vars.hair):
			1:
				hair.animation = "hair2"	
			2:
				hair.animation = "hair3"		
			3:
				hair.animation = "hair4"
			4:
				hair.animation = "hair5"
			5:
				hair.animation = "hair6"	
			6:
				hair.animation = "hair7"
			7:
				hair.animation = "hair8"
			8:
				hair.animation = "hair1"
		match(global_vars.eyes):
			0:
				eyes.animation = "eye1"	
			1:
				eyes.animation = "eye2"		
			2:
				eyes.animation = "eye3"
			3:
				eyes.animation = "eye4"
			4:
				eyes.animation = "eye5"			
func get_idle_up():
		match(global_vars.body):
			0:
				animatedSprite.animation = "body1_idleup"	
			1:
				animatedSprite.animation = "body2_idleup"		
			2:
				animatedSprite.animation = "body3_idleup"
			3:
				animatedSprite.animation = "body4_idleup"
			4:
				animatedSprite.animation = "body5_idleup"
		match(global_vars.hair):
			1:
				hair.animation = "hair2_idleup"	
			2:
				hair.animation = "hair3_idleup"		
			3:
				hair.animation = "hair4_idleup"
			4:
				hair.animation = "hair5_idleup"
			5:
				hair.animation = "hair6_idleup"	
			6:
				hair.animation = "hair7_idleup"
			7:
				hair.animation = "hair8_idleup"
			8:
				hair.animation = "hair1_idleup"
func get_idle_right():
		match(global_vars.body):
			0:
				animatedSprite.animation = "body1_idle_right"
			1:
				animatedSprite.animation = "body2_idle_right"		
			2:
				animatedSprite.animation = "body3_idle_right"
			3:
				animatedSprite.animation = "body4_idle_right"
			4:
				animatedSprite.animation = "body5_idle_right"
		match(global_vars.eyes):
			0:
				eyes.animation = "eye1_idle_right"	
			1:
				eyes.animation = "eye2_idle_right"		
			2:
				eyes.animation =  "eye3_idle_right"
			3:
				eyes.animation = "eye4_idle_right"
			4:
				eyes.animation = "eye5_idle_right"				
func get_eye_idle_right():					
		match(global_vars.eyes):
			0:
				return "eye1_idleright"	
			1:
				return "eye2_idleright"		
			2:
				return  "eye3_idleright"
			3:
				return "eye4_idleright"
			4:
				return "eye5_idleright"
				
func get_hair_idle_right():
		match(global_vars.hair):
			1:
				return "hair2_idleright"	
			2:
				return "hair3_idleright"		
			3:
				return "hair4_idleright"
			4:
				return "hair5_idleright"
			5:
				return "hair6_idleright"	
			6:
				return "hair7_idleright"
			7:
				return "hair8_idleright"
			8:
				return "hair1_idleright"					
					
func get_walk_down():
		match(global_vars.body):
			0:
				return "body1_down"
			1:
				return "body2_down"
			2:
				return "body3_down"
			3:
				return "body4_down"
			4:
				return "body5_down"	
func get_hair_down():							
		match(global_vars.hair):
			1:
				return "hair2_walkdown"	
			2:
				return "hair3_walkdown"		
			3:
				return "hair4_walkdown"
			4:
				return "hair5_walkdown"
			5:
				return "hair6_walkdown"	
			6:
				return "hair7_walkdown"
			7:
				return "hair8_walkdown"
			8:
				return "hair1_walkdown"
func get_eyes_down():
	match(global_vars.eyes):
		0:
			return "eye1_walkdown"	
		1:
			return "eye2_walkdown"		
		2:
			return  "eye3_walkdown"
		3:
			return  "eye4_walkdown"
		4:
			return "eye5_walkdown"			
			
func get_walk_right():
		match(global_vars.body):
			0:
				return "body1_walkright"
			1:
				return "body2_walkright"
			2:
				return "body3_walkright"
			3:
				return "body4_walkright"
			4:
				return "body5_walkright"
func eye_walk_right():					
		match(global_vars.eyes):
			0:
				return "eye1_walkright"
			1:
				return "eye2_walkright"	
			2:
				return "eye3_walkright"
			3:
				return "eye4_walkright"
			4:
				return "eye5_walkright"		
func get_hair_right():
		match(global_vars.hair):
			1:
				return "hair2_walkright"	
			2:
				return "hair3_walkright"		
			3:
				return "hair4_walkright"
			4:
				return "hair5_walkright"
			5:
				return "hair6_walkright"	
			6:
				return "hair7_walkright"
			7:
				return "hair8_walkright"
			8:
				return "hair1_walkright"												
