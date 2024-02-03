extends Player_State
class_name Air_State

func _on_enter():
	pass

func _on_exit():
	pass

func _physics_process(_delta):
	if get_parent().current_state==self:
		if not get_parent().get_parent().velocity.y:
			transition.emit("Grounded")
		if get_parent().get_parent().velocity.y < 0 or Input.is_action_pressed("Move_Down"):
			get_parent().get_parent().set_collision_mask_value(2, false)
		else:
			get_parent().get_parent().set_collision_mask_value(2, true)
		if get_parent().get_parent().Wall_checker.is_colliding():
			if Input.is_action_pressed("Move_Left") or Input.is_action_pressed("Move_Right"):
				transition.emit("Wall Cling")
