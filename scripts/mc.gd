extends CharacterBody3D


const SPEED = 10.0
const AIMING_ARM_OFFSET = -0.791

const NORMAL_ARM_OFFSET = 4.0

var aiming=false

var attacking = false



var ammo = 10

const AMMO_MAX = 100


func add_ammo(number_of_bullets):
	
	ammo+= number_of_bullets
	
	if ammo > AMMO_MAX:
		ammo = AMMO_MAX
		return ammo - AMMO_MAX
	else:
		return 0


func attack():
	if ammo > 0 and !attacking:	
		ammo -= 1
		attacking = true
	
	
	pass

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func _input(event):
	
	if event is InputEventMouseMotion:
		var ev = event as InputEventMouseMotion
		
		rotate_y(ev.relative.x * -0.007)
		#rotation_degrees.y = clampf(rotation_degrees.y,-20,20)
		$arm.rotate_x(ev.relative.y * -0.01)
		$arm.rotation_degrees.x = clampf($arm.rotation_degrees.x,-33,33)
		
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == 2 and event.pressed:
			var aiming_tween = create_tween()
			var pov_tween = create_tween()
			if aiming:
				aiming_tween.tween_property($arm,"spring_length",NORMAL_ARM_OFFSET,0.5)
				pov_tween.tween_property($arm/Camera3D,"fov",75,0.25)
				$aim.rotation_degrees = Vector3.ZERO
			else :
				aiming_tween.tween_property($arm,"spring_length",AIMING_ARM_OFFSET,0.5)
				pov_tween.tween_property($arm/Camera3D,"fov",40,0.25)
			
			aiming = !aiming
		

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
	
	if aiming:
		$aim.rotation = $arm.rotation


func _on_timer_timeout():
	attacking = false
