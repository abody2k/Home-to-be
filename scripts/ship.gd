extends CharacterBody3D


func _on_talking_to_captin_body_entered(body):
	GlobalData.start_new_mission()
	queue_free()
