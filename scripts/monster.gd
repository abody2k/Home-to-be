extends CharacterBody3D
enum MODES {SEARCHING, IDLE, EATING, ATTACKING, HUNTING}


var target : CharacterBody3D

var mode : MODES = MODES.IDLE

var eating = false

var player : CharacterBody3D
var soliders = []
var islanders  = []

@export var path : PathFollow3D



func reset_location():
	reparent(path)
	transform.origin = Vector3.ZERO

func _ready():
	create_tween().tween_callback(reset_location).set_delay(0.1)
	
	
	
func _physics_process(delta):
	
	
	match mode:
		MODES.ATTACKING:
			$AnimationPlayer.play("rig_001|monster_attack")
			#$AnimationPlayer.stop()
			return
		MODES.IDLE:
			pass
			#path.progress_ratio+=delta * 0.01

func _on_detector_body_entered(body : CharacterBody3D):
	
	if eating:
		return
		
	if body.collision_layer == 16:
		if not islanders.has(body):
			islanders.push_back(body)
		return
	if body.collision_layer == 4:
		if not soliders.has(body):
			soliders.push_back(body)
		return
	
	player = body
	mode = MODES.HUNTING
	
	
	
	#if mode != MODES.GOING_HOME:
		#target = body
		#mode = MODES.HUNTING
