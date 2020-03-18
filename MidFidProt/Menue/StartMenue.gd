extends Node



func _ready():
	$MarginContainer/VBoxContainer/MenuButton.grab_focus()
func _physics_process(delta):
	if $MarginContainer/VBoxContainer/MenuButton.is_hovered() == true:
		$MarginContainer/VBoxContainer/MenuButton.grab_focus()




func _on_MenuButton_pressed():
	get_tree().change_scene("res://TestStage.tscn")


func _on_MenuButton2_pressed():
	get_tree().quit()
