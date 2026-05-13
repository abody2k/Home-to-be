extends CharacterBody3D
enum MODES {WALKING, HUNTING, STANDING, GOING_HOME, SLEEPING}


var target : CharacterBody3D

var mode : MODES = MODES.WALKING

@export var path : PathFollow3D



func reset_location():
	reparent(path)
	transform.origin = Vector3.ZERO

func _ready():
	create_tween().tween_callback(reset_location).set_delay(0.1)
	
	
	
func _physics_process(delta):
	
	
	match mode:
		MODES.STANDING:
			$AnimationPlayer.play("rig_001|monster_attack")
			$AnimationPlayer.stop()
			return
		MODES.WALKING:
			path.progress_ratio+=delta * 0.01

func _on_detector_body_entered(body):
	if mode != MODES.GOING_HOME:
		target = body
		mode = MODES.HUNTING
