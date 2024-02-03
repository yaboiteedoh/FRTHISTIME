extends Player_State
class_name Jumping

func _on_enter():
	get_parent().get_parent().set_collision_mask_value(2, false)

func _on_exit():
	get_parent().get_parent().set_collision_mask_value(2, true)

func _physics_process(_delta):
	if get_parent().current_state==self:
		if not get_parent().get_parent().velocity.y:
			transition.emit("Grounded")
		if get_parent().get_parent().velocity.y > 0:
			transition.emit("Air_State")
