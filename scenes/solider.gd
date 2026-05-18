extends "res://scripts/boat.gd"
var player : CharacterBody3D



func _physics_process(delta):
	if player:
		var dir = player.global_position - global_position
		dir.y = 0
		var normalized_dir = dir.normalized()
		look_at(normalized_dir)
		velocity = normalized_dir
		move_and_slide()
		
