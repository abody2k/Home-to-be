extends CharacterBody3D


@export var path : PathFollow3D


func finish_job():
	print("BOAT REACHED SHORE AND FINISH JOB IS CALLED")
	GlobalData.mission_completed()
	GlobalData.start_new_mission()
		
func _on_area_3d_body_entered(body):
	create_tween().tween_property(path,"progress_ratio",1.0,10).finished.connect(finish_job)
