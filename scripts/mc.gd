extends CharacterBody3D


const SPEED = 10.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func _input(event):
	
	if event is InputEventMouseMotion:
		var ev = event as InputEventMouseMotion
		
		rotate_y(ev.relative.x * -0.007)
		#rotation_degrees.y = clampf(rotation_degrees.y,-20,20)
		$arm.rotate_x(ev.relative.y * -0.01)
		$arm.rotation_degrees.x = clampf($arm.rotation_degrees.x,-33,33)
		

var up_down = 0
var left_right = 0
func _physics_process(delta):
	up_down = -Input.get_axis("backward","forward")
	left_right = Input.get_axis("left","right")
	if up_down == 0 and left_right ==0 :
		velocity = Vector3.ZERO
	velocity = transform.basis.z * up_down
	velocity += transform.basis.x * left_right
	velocity *= SPEED
	move_and_slide()
