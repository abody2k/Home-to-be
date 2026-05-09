extends Area3D


var food_value : float  = 1.0


func _ready():
	food_value = randf_range(5,10)

func eaten():
	queue_free()
	

func _on_body_entered(body):
	body.food_is_there = self
