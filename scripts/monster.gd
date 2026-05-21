extends CharacterBody3D
enum MODES {SEARCHING, IDLE, EATING, HUNTING}


var target : CharacterBody3D

var mode : MODES = MODES.IDLE

var eating = false
var reached_body = false
var is_down = false


var player : CharacterBody3D


var has_a_target = false


@export var path : PathFollow3D



func reset_location():
	return
	reparent(path)
	transform.origin = Vector3.ZERO

func _ready():
	create_tween().tween_callback(reset_location).set_delay(0.1)
	
	
var attacking = false


func _physics_process(delta):
	
	
	match mode:
		MODES.IDLE:
			return
			
		MODES.HUNTING:
			if attacking:
				return
				
			if player:
				if player.global_position.distance_to(global_position) < 4:
					#print([attacking,is_down])
					if not player.is_down:
						print("player is not down")
						if attacking:
							print("attackong")
							return
						else:
							print("Just started an attack")
							attacking = true
							$AnimationPlayer2.play("rig_001|monster_attack")
						
						return
						
					if not reached_body:
						reached_body = true
						$AnimationPlayer2.play("monster_get_down_to_eat")
				else:
					print(player.global_position.distance_to(global_position))
					print("WALKING")
					$AnimationPlayer2.play("rig_001|monster_walk")
					look_at(Vector3(player.global_position.x,global_position.y,player.global_position.z))
					velocity = -basis.z * 5
					velocity.y = -10
					move_and_slide()
					
			return
			#path.progress_ratio+=delta * 0.01

func _on_detector_body_entered(body : CharacterBody3D):
	
	if eating or has_a_target or (body.hunter != null):
		return
	has_a_target = true
	body.hunter = self
	
	print("assigned a new target")
	
	player = body
	mode = MODES.HUNTING
	
	
	
	#if mode != MODES.GOING_HOME:
		#target = body
		#mode = MODES.HUNTING


func _on_animation_player_2_animation_finished(anim_name):
	if anim_name == "rig_001|monster_get_down_to_eat":
		$AnimationPlayer2.play("rig_001|eating")
	elif anim_name == "rig_001|monster_attack":
		attacking = false



func _on_area_3d_body_entered(body):
	print(body)
	print(player)
	print([( (body  != player)) , not attacking])
	if ( (body  != player)) or not attacking:
		return
	
	player.is_down = true
	attacking = true
	eating = true
	player.die()
	$AnimationPlayer2.play("rig_001|monster_get_down_to_eat")
	mode = MODES.EATING
	
		
