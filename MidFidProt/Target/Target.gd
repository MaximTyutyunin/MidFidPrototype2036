extends KinematicBody2D


#func _ready():
#	if get_slide_count() > 0:
#		for i in range(get_slide_count()):
#			if "KinematicBody2D" in get_slide_collision(i).collider.name:
#				get_tree().change_scene("res://Menue.tscn")




#func _on_Timer_timeout():
#	get_tree().change_scene("res://Menue/Menue.tscn")


func _on_Area2D_area_entered(area):
	get_tree().change_scene("res://Menue/Menue.tscn")
