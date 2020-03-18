extends KinematicBody2D

export (int) var hp = 2
export (int) var speed = 200
export (int) var jump_speed = -650
export (int) var gravity = 2500
export (float, 0, 1.0) var friction = 0.26#sdfg
export (float, 0, 1.0) var acceleration = 0.25#sdrg

var facingRight = true
#var hp = 2

var velocity = Vector2.ZERO
var is_dead = false
onready var asp2d = get_node("AudioStreamPlayer2D")#хрень какая-то
onready var asp2d2 = get_node("AudioStreamPlayer2D2")#хрень какая-то
onready var asp2d3 = get_node("AudioStreamPlayer2D3")#хрень какая-то

func get_input():
	if is_dead == false:#может все ломать
		var dir = 0 #get_node("..").position +
		if Input.is_action_pressed("ui_right"):
			facingRight = true
			dir += 1
			asp2d3.play()
		if Input.is_action_pressed("ui_left"):
			facingRight = false	
			dir -= 1
			asp2d3.play()
		if dir != 0:
			velocity.x = lerp(velocity.x, dir * speed, acceleration)#iterpolation applied here
		else:
			velocity.x = lerp(velocity.x, 0, friction)#and here
			
		if Input.is_action_just_pressed("ui_hit"):
			var x = 13
			if !facingRight:
				x*=-1
			$Weapon.position =  Vector2(x, 0)
			yield (get_tree ().create_timer(0.1),"timeout")
			$Weapon.position =  Vector2.ZERO
		#print (gravity)# to check how it is applied

func _physics_process(delta):
	
	get_input()
	velocity.y += (gravity*1.6 * delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed
			asp2d2.play(0)
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Enemy" in get_slide_collision(i).collider.name:#может ломать
				dead()

func dead():#это может все ломать
	hp -= 1
	if hp < 0:
		is_dead = true
		asp2d.play(0)
		velocity = Vector2(0,0)
		$CollisionShape2D.set_deferred("disabled", true)
		gravity = 0
		get_parent().get_node("ScreenShake").screen_shake(1,5,50)
		$Timer.start()
	
	


func _on_Timer_timeout():
	get_tree().change_scene("res://Menue/Menue.tscn")
