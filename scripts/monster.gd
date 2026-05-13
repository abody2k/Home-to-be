extends CharacterBody3D
enum MODES {WALKING, HUNTING, STANDING, GOING_HOME}


var target : CharacterBody3D

var mode : MODES = MODES.WALKING


func _on_detector_body_entered(body):
	if mode != MODES.GOING_HOME:
		target = body
		mode = MODES.HUNTING
