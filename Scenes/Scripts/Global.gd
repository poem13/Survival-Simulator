extends Node

var body : int = 0
var eyes : int = 0
var hair : int = 1
var scene
var paused = false
var loaded = false

var music_enabled : bool
var fx_enabled : bool
var music_volume : bool
var fx_volume: bool

var state = "day"


func set_body():
	if(body >= 4): body = 0
	else: body += 1
func set_eyes():	
	if(eyes >= 4): eyes = 0
	else: eyes += 1	
func set_hair():	
	if(hair >= 8): hair = 1
	else: hair += 1	
