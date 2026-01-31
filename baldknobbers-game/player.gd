extends CharacterBody2D


const SPEED = 300.0


func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX := Input.get_axis("walk_left", "walk_right")
	var directionY := Input.get_axis("walk_up", "walk_down")
	
	if directionX or directionY:
		velocity = Vector2(directionX,directionY).normalized()*SPEED
	else:
		velocity *= 0.9

	move_and_slide()
