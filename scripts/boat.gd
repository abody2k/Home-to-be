extends CharacterBody3D


@export var path : PathFollow3D


func finish_job():
	
	GlobalData.mission_completed()
	GlobalData.start_new_mission()
	print("Finished job")
		
func _on_area_3d_body_entered(body):
	finish_job()
	create_tween().tween_property(path,"progress_ratio",1.0,30).finished.connect(_remove_area)
	

func _remove_area():
	$Area3D.queue_free()
	finish_job()
	
