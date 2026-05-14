extends CharacterBody3D


const SPEED = 10.0
const AIMING_ARM_OFFSET = -0.791

const NORMAL_ARM_OFFSET = 4.0

var aiming=false

var attacking = false


var food = 100.0 :
	set(value):
		$CanvasLayer/Control/food.value = (value)
		food = value
var food_is_there : Area3D



var ammo = 10:
	set(value):
		ammo = value
		$CanvasLayer/Control/HBoxContainer/bullets.text = str(value)

const AMMO_MAX = 100

var jumping = false

var hp = 100.0:
	set(value):
		hp = value
		$CanvasLayer/Control/hp.value = value


var eating = false



func eat_food(food_value):
	eating = true
	
	var food_tween = create_tween()
	food_tween.finished.connect(func(): eating = false)
	if food_value + food > 100.0:
		food_tween.tween_property(self,"food",100.0,0.25)
	else:
		var x = food_value + food
		food_tween.tween_property(self,"food",x,0.25)
	food_is_there.eaten()
	food_is_there = null
	
	#every time food is eaten the food indicator change
	
	


func add_ammo(number_of_bullets):
	
	ammo+= number_of_bullets
	
	if ammo > AMMO_MAX:
		ammo = AMMO_MAX
		return ammo - AMMO_MAX
	else:
		return 0


func attack():


	if ammo > 0 and !attacking:	
		print("Bang!")
		ammo -= 1
		attacking = true
		$Timer.start()


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func _input(event):
	if Input.is_action_just_pressed("eat") and food_is_there:
		eat_food(food_is_there.food_value)
		
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

var jump_vector = Vector3.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("attack"):
		attack()
			
	if not eating:
		food -= delta * 0.5
	
	if jumping:
		
		velocity = jump_vector
		move_and_slide()
		return
		
	up_down = -Input.get_axis("backward","forward")
	left_right = Input.get_axis("left","right")
	
	

		
	if Input.is_action_just_pressed("jump"):
		jumping = true
		jump_vector = transform.basis.z * up_down  + transform.basis.x * left_right + Vector3.UP
		jump_vector *= SPEED
		$jumping.start()
		return
	if up_down == 0 and left_right ==0 :
		velocity = Vector3.DOWN * 4
		$AnimationPlayer.play("rig_005|mc_idle")
		move_and_slide()
		return
		
	velocity = transform.basis.z * up_down
	velocity += transform.basis.x * left_right
	
	velocity *= SPEED
	$AnimationPlayer.play("rig_005|mc_walking_001")
	move_and_slide()
	

	
	if aiming:
		$aim.rotation = $arm.rotation
	


func update_dialogs(new_dialogs):
	$dialog.update_dialogs(new_dialogs)
	
	
func _on_timer_timeout():
	attacking = false


func _on_jumping_timeout():
	jumping = false
