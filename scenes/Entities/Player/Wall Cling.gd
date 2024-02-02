extends Player_State
class_name Wall_Cling

func _physics_process(_delta):
	if get_parent().current_state==self:
		if not get_parent().get_parent().Wall_checker.is_colliding():
			transition.emit("Air_State")
		if not Input.is_action_pressed("Move_Left") and not Input.is_action_pressed("Move_Right"):
			transition.emit("Air_State")

func _on_enter():
	get_parent().get_parent().jumps = get_parent().get_parent().max_jumps
	get_parent().get_parent().velocity.y = 0
