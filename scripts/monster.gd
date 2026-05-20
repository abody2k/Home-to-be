extends CharacterBody3D
enum MODES {SEARCHING, IDLE, EATING, ATTACKING, HUNTING}


var target : CharacterBody3D

var mode : MODES = MODES.IDLE

var eating = false
var reached_body = false
var is_down = false


var player : CharacterBody3D
var soliders = []
var islanders  = []

var has_a_target = false


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
			return
			
		MODES.EATING:
			if player:
				if player.global_position.distance_to(global_position) < 2:
					if not reached_body:
						reached_body = true
						$AnimationPlayer2.play("monster_get_down_to_eat")
				else:
					$AnimationPlayer2.play("rig_001|monster_walk")
					look_at(player.global_position)
					velocity = basis.z * 5
					move_and_slide()
					
			return
			#path.progress_ratio+=delta * 0.01

func _on_detector_body_entered(body : CharacterBody3D):
	
	if eating or has_a_target:
		return
	has_a_target = true
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


func _on_animation_player_2_animation_finished(anim_name):
	if anim_name == "monster_get_down_to_eat":
		$AnimationPlayer2.play("rig_001|eating")
