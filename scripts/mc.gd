extends CharacterBody3D


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	
	if event is InputEventMouseMotion:
		var ev = event as InputEventMouseMotion
		
		$arm/Camera3D.rotate_x(ev.relative.y * -0.007)
		$arm/Camera3D.rotation_degrees.x = clampf($arm/Camera3D.rotation_degrees.x,-20,20)
		$arm.rotate_y(ev.relative.x * -0.01)
		$arm.rotation_degrees.y = clampf($arm.rotation_degrees.y,-89,89)
