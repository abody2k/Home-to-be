extends CharacterBody3D


@export var destination : Node3D
const SPEED = 20.0
const AIMING_ARM_OFFSET = -0.791

const NORMAL_ARM_OFFSET = 4.0

enum MODES {
	
	DIALOG,FPS, IDLE
}

var mode : MODES = MODES.DIALOG

var aiming=false

var attacking = false



var food = 100.0 :
	set(value):
		$CanvasLayer/Control/food.value = (value)
		food = value
var food_is_there : Area3D



var ammo = 0:
	set(value):
		ammo = value
		$CanvasLayer/Control/HBoxContainer/bullets.text = str(value)
		if ammo == 0:
			GlobalData.mission_completed()
			GlobalData.start_new_mission()

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
	


func add_ammo(number_of_bullets):
	
	ammo+= number_of_bullets
	
	if ammo > AMMO_MAX:
		ammo = AMMO_MAX
		return ammo - AMMO_MAX
	else:
		return 0



func attack():
	if mode == MODES.IDLE:
		return
		

	if mode == MODES.DIALOG:
		$dialog.next()
	else:
		if ammo > 0 and !attacking:	
			ammo -= 1
			attacking = true
			$Timer.start()

func chng_color(alpha):
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(1.0,1.0,1,alpha)
	($CanvasLayer/Control/time as Panel).add_theme_stylebox_override("panel",style_box)
	#$CanvasLayer/Control/time.add_theme_color_override("bg_color",Color(1,1,1,alpha))
	

func teleport():
	global_position = destination.global_position
	create_tween().tween_method(chng_color,1.0,0.0,2).finished.connect(func (): $CanvasLayer/Control.visible = false)
	GlobalData.mission_completed()
	GlobalData.start_new_mission()
	mode = MODES.IDLE
	
	
func flash_screen():
	create_tween().tween_method(chng_color,0.0,1.0,2).finished.connect(teleport)

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	#play waking up animation
	
	#go to the captain
	$dialog.next()



func _input(event):
	
	if mode == MODES.IDLE:
		return
	if mode == MODES.DIALOG:
		return
		
		
	if Input.is_action_just_pressed("eat") and food_is_there:
		eat_food(food_is_there.food_value)
		
	if event is InputEventMouseMotion:
		var ev = event as InputEventMouseMotion
		
		rotate_y(ev.relative.x * -0.007)
		#rotation_degrees.y = clampf(rotation_degrees.y,-20,20)
		$arm.rotate_x(ev.relative.y * -0.01)
		$arm.rotation_degrees.x = clampf($arm.rotation_degrees.x,-33,33)
		$aim.rotation_degrees.x = $arm.rotation_degrees.x
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == 2 and event.pressed:
			var aiming_tween = create_tween()
			var pov_tween = create_tween()
			if aiming:
				$aim/rifle2.visible=false
				aiming_tween.tween_property($arm,"spring_length",NORMAL_ARM_OFFSET,0.5)
				pov_tween.tween_property($arm/Camera3D,"fov",75,0.25)
				$aim.rotation_degrees = Vector3.ZERO
			else :
				$aim/rifle2.visible=true
				aiming_tween.tween_property($arm,"spring_length",AIMING_ARM_OFFSET,0.5)
				pov_tween.tween_property($arm/Camera3D,"fov",40,0.25)
			
			aiming = !aiming
		

var up_down = 0
var left_right = 0

var jump_vector = Vector3.ZERO

func _physics_process(delta):
	
	if mode == MODES.IDLE:
		velocity = Vector3.DOWN * 4
		$AnimationPlayer.play("mc|mc_idle")
		move_and_slide()
		return
	
	if Input.is_action_pressed("attack"):
		attack()
	
	if mode == MODES.DIALOG:
		return
		
	if not eating:
		food -= delta * 0.5
	
	if jumping:
		
		velocity = jump_vector
		move_and_slide()
		return
		
	up_down = -Input.get_axis("backward","forward")
	left_right = Input.get_axis("left","right")
	
	

		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true
		jump_vector = transform.basis.z * up_down  + transform.basis.x * left_right + Vector3.UP
		jump_vector *= SPEED
		$jumping.start()
		return
	if up_down == 0 and left_right ==0 or not is_on_floor() :
		velocity = Vector3.DOWN * 40
		$AnimationPlayer.play("mc|mc_idle")
		move_and_slide()
		return
		

	
	if is_on_floor():
		velocity = transform.basis.z * up_down
		velocity += transform.basis.x * left_right
		velocity *= SPEED
		move_and_slide()
		$AnimationPlayer.play("mc|mc_walking")
	

	
	if aiming:
		$aim.rotation = $arm.rotation
	


func update_dialogs(new_dialogs):
	mode = MODES.DIALOG
	$dialog.update_dialogs(new_dialogs)
	
	
func _on_timer_timeout():
	attacking = false


func _on_jumping_timeout():
	jumping = false


func _on_dialog_finished_dialog():
	print("dialog finished")
	mode = MODES.FPS


func _on_mc_reached_house_body_entered(body):
	GlobalData.mission_completed()
	GlobalData.start_new_mission()
	get_parent().get_node("mc_reached_house").queue_free()


func _on_reaching_cells_body_entered(body):
	GlobalData.mission_completed()
	GlobalData.start_new_mission()
	get_parent().get_node("reaching_cells").queue_free()


func _on_mc_reached_caves_body_entered(body):
	GlobalData.mission_completed()
	GlobalData.start_new_mission()
	get_parent().get_node("mc_reached_caves").queue_free()


func _on_reached_time_machine_body_entered(body):
	GlobalData.mission_completed()
	GlobalData.start_new_mission()
	get_parent().get_node("reached_time_machine").queue_free()


func _on_time_travel_zone_body_entered(body):
	$CanvasLayer/Control/time.visible= true
	flash_screen()

	GlobalData.mission_completed()
	GlobalData.start_new_mission()
	get_parent().get_node("reached_time_machine").queue_free()
