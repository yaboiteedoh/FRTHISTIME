extends Player_State
class_name Dash

func _on_enter():
	get_parent().get_parent().dashes -= 1
	get_parent().get_parent().velocity.y = 0
	if get_parent().get_parent().facing == "Left":
		get_parent().get_parent().velocity.x = -100
	else:
		get_parent().get_parent().velocity.x = 100
	$Timer.start()

func _on_timer_timeout():
	transition.emit("Air_State")
