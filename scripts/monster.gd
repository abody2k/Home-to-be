extends CharacterBody3D
enum MODES {WALKING, HUNTING, STANDING, GOING_HOME, SLEEPING}


var target : CharacterBody3D

var mode : MODES = MODES.WALKING

@export var path : PathFollow3D


func _ready():
	reparent(path)
	transform.origin = Vector3.ZERO
	
	
func _physics_process(delta):
	
	
	match mode:
		MODES.STANDING:
			$AnimationPlayer.play("rig_001|monster_attack")
			$AnimationPlayer.stop()
			return
		MODES.WALKING:
			path.progress_ratio+=delta

func _on_detector_body_entered(body):
	if mode != MODES.GOING_HOME:
		target = body
		mode = MODES.HUNTING
