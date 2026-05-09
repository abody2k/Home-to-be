extends Area3D




func eaten():
	queue_free()
	

func _on_body_entered(body):
	body.food_is_there = self
