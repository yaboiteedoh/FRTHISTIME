extends Node
class_name Room

var active:bool=false
@onready var anchor_pos = $Camera_anchor.get_global_position()

signal activated(room)
signal deactivated(room)


func _on_area_2d_body_entered(_body):
	active = true
	activated.emit(self)

func _on_area_2d_body_exited(_body):
	active = false
	deactivated.emit(self)
