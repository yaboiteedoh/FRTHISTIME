extends Player_State
class_name Grounded

func _physics_process(_delta):	
	if get_parent().current_state==self:
		if get_parent().get_parent().velocity.y > 0:
			transition.emit("Air_State")
		if get_parent().get_parent().velocity.y < 0:
			transition.emit("Jumping")
		if Input.is_action_pressed("Move_Down"):
			get_parent().get_parent().set_collision_mask_value(2, false)
		else:
			get_parent().get_parent().set_collision_mask_value(2, true)

func _on_enter():
	get_parent().get_parent().jumps = get_parent().get_parent().max_jumps
	get_parent().get_parent().dashes = get_parent().get_parent().max_dashes
