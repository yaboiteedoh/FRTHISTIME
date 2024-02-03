extends CharacterBody2D
class_name Player

var move_direction
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumps:int
var max_jumps = 1
var facing:String
var dashes:int
var max_dashes = 1
@onready var Wall_checker = $Wall_checker

func _physics_process(delta):
	if facing == "Left":
		Wall_checker.set_target_position(Vector2(-2,0))
	elif facing == "Right":
		Wall_checker.set_target_position(Vector2(2,0))
	elif facing == "Neither":
		Wall_checker.set_target_position(Vector2.ZERO)
	if $State_Machine.current_state.can_move:
		if $State_Machine.current_state is Air_State or $State_Machine.current_state is Grounded or $State_Machine.current_state is Jumping:
			velocity.y += gravity * delta
		move_direction = Input.get_axis("Move_Left", "Move_Right")
		if move_direction:
			velocity.x = move_direction * $State_Machine.current_state.speed
			if move_direction < 0:
				facing = "Left"
			elif move_direction > 0:
				facing = "Right"
			else:
				facing = "Neither"
		else:
			velocity.x = 0
	if Input.is_action_just_pressed("Jump") && jumps:
		_jump(delta)
	if Input.is_action_just_pressed("Dash") && dashes && not $State_Machine.current_state.name == "Dash":
		_dash()
	move_and_slide()
	print($State_Machine.current_state.name)

func _jump(delta):
	jumps -= 1
	velocity.y = $State_Machine.current_state.jump_strength
	$State_Machine.current_state.transition.emit("Jumping")
	
func _dash():
	$State_Machine.current_state.transition.emit("Dash")
