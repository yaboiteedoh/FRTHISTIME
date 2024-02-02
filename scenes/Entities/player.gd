extends CharacterBody2D


const speed = 50.0
const jump_velocity = -400.0
var move_direction

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	move_direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	if move_direction:
		velocity.x = move_direction.x * speed
		velocity.y = move_direction.y * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
