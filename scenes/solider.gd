extends "res://scripts/boat.gd"
var player : CharacterBody3D

func remove_player():
	player = null

func _physics_process(delta):
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
			$AnimationPlayer.stop()
			
		
