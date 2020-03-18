extends KinematicBody2D

const GRAV = 10
const FL = Vector2(0,-1)

var vel = Vector2()
var direct = 1
var is_dead = false

export(int) var speed = 30
export(int) var hp = 1

func _ready():
	pass
#here will be the code for sprite flipping
#
func _physics_process(delta):
	vel.x = speed * direct
	
	vel.y += GRAV
	vel  = move_and_slide(vel,FL)
	if is_on_wall():
		direct = direct  * -1 
		$RayCast2D.position.x *= -1
	if $RayCast2D.is_colliding() == false:
		direct = direct * -1
		$RayCast2D.position.x *= -1
		
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "KinematicBody2D" in get_slide_collision(i).collider.name:#might be not kin body 2d
					get_slide_collision(i).collider.dead()#может ломать

#this methos kills enemy :
func _on_Area2D_area_entered(area):
	print('hit')
	hp -= 1
	if hp <= 0:
		is_dead = true
		vel = Vector2(0,0)
		$CollisionShape2D.set_deferred("disabled", true)
