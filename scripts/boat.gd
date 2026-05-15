extends CharacterBody3D


@export var path : PathFollow3D


func _on_area_3d_body_entered(body):
	GlobalData.mission_completed()
	GlobalData.start_new_mission()
	create_tween().tween_property(path,"progress_ratio",1.0,30)
