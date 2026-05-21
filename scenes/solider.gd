extends "res://scripts/boat.gd"
var player : CharacterBody3D


var hunter : CharacterBody3D 
var is_down = false

var shooting_mode = false


func enable_shooting_mode():
	shooting_mode = true
	$detector.monitoring = true

var dead = false

func die():
	print("solider is dying")
	$AnimationPlayer.play("rig_004|islander_death")
	dead = true
	
	remove_player()
	
	
func remove_player():
	player = null

func _physics_process(delta):
	if dead:
		return
	if player:
		var dir = player.global_position - global_position
		dir.y = 0
		var normalized_dir = dir.normalized()
		var target = player.global_position
		target.y =global_position.y
		
		look_at(target)
		
		if global_position.distance_to(player.global_position) > 15:
			velocity = normalized_dir * 15
			velocity += Vector3.DOWN * 20
			move_and_slide()
			$AnimationPlayer.play("rig_004|solider_walking")
		else:
			velocity = Vector3.DOWN * 20
			move_and_slide()
			$AnimationPlayer.stop()
	else:
			velocity = Vector3.DOWN * 20
			move_and_slide()
			$AnimationPlayer.stop()
			
		


func _on_detector_body_entered(body):
	look_at(Vector3(body.global_position.x,global_position.y,body.global_position.z))
	$shooting.play()
	body.die()
