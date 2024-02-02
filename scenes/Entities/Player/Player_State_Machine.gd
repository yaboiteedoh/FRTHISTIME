extends Node
class_name Player_State_Machine

var states={}
var current_state:Player_State

func _ready():
	for child in get_children():
		if child is Player_State:
			states[child.name] = child
			child.transition.connect(_transition)
		else:
			print(child.name + " is not a Player_State")
	current_state = states["Air"]

func _transition(new_state:String):
	var next_state = states[new_state]
	current_state._on_exit()
	$Label.set_text("State: Transition")
	current_state = next_state
	next_state._on_enter()
	$Label.set_text("State : " + new_state)
