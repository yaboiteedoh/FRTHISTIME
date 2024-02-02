extends CharacterBody2D
class_name Player

var move_direction
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if $State_Machine.current_state.can_move:
		move_direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
		if move_direction:
			velocity.x = move_direction.x * $State_Machine.current_state.speed
			velocity.y = move_direction.y * $State_Machine.current_state.speed
		else:
			velocity.x = move_toward(velocity.x, 0, $State_Machine.current_state.speed)
			velocity.y = move_toward(velocity.y, 0, $State_Machine.current_state.speed)

		move_and_slide()
