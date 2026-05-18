extends "res://scripts/boat.gd"
var player : CharacterBody3D



func _physics_process(delta):
	if player:
		var dir = player.global_position - global_position
		dir.y = 0
		var normalized_dir = dir.normalized()
		var target = player.global_position
		target.y =global_position.y
		look_at(target)
		velocity = normalized_dir * 15
		if global_position.distance_to(player.global_position) > 15:
			move_and_slide()
		
