extends CharacterBody3D


func _on_talking_to_captin_body_entered(body):
	GlobalData.start_new_mission()
	$Cube_010/Cube_011/talking_to_captin.queue_free()
