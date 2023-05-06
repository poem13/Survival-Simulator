extends Node2D

onready var hair = $Player/Hair
onready var eyes = $Player/Eyes
onready var skin = $Player/Base
onready var hairCount : int = 1
onready var skinCount : int = 1
onready var eyeCount : int = 1
onready var outfit : int = 1


func _on_Skin_Button_pressed():
	if(skinCount > 5):
		skinCount = 1
		skin.play("skin" + str(skinCount))
		skin.set_playing(false)
	else:
		skin.play("skin" + str(skinCount))
		skin.set_playing(false)
	skinCount += 1


func _on_Hair_Button_pressed():
	if(hairCount > 8):
		hairCount = 1
		hair.play("hair" + str(hairCount))
		hair.set_playing(false)
	else:
		hair.play("hair" + str(hairCount))
		hair.set_playing(false)
	hairCount += 1

func _on_Eyes_Button_pressed():
	if(eyeCount > 5):
		eyeCount = 1
		eyes.play("eye" + str(eyeCount))
		eyes.set_playing(false)
	else:
		eyes.play("eye" + str(eyeCount))
		eyes.set_playing(false)
	eyeCount += 1


func _on_Back_Button_pressed():
	SceneChanger.change_scene('res://MainMenu.tscn', 'fade')


func _on_Next_Button_pressed():
	#Global.playerSkin = skinCount
	Global.playerSkin = 1
	SceneChanger.change_scene('res://Main.tscn', 'fade')
