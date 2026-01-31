extends CharacterBody2D


const SPEED = 300.0
var waterTexture = load("res://Sprites/WaterDrop.png")
var fireTexture = load("res://Sprites/Fireball.png")
var isWater:bool = true


func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX := Input.get_axis("walk_left", "walk_right")
	var directionY := Input.get_axis("walk_up", "walk_down")
	
	if directionX or directionY:
		velocity = Vector2(directionX,directionY).normalized()*SPEED
		if directionX == 1:
			rotation = 0
		elif directionX == -1:
			rotation = PI
		elif directionY == 1:
			rotation = PI/2
		elif directionY == -1:
			rotation = -PI/2
	else:
		velocity *= 0.9
	
	if Input.is_action_just_pressed("add_water") and not $Particles.emitting == false:
		$Particles.texture = waterTexture
		$Particles.emitting = true
		isWater = true
		
	if Input.is_action_just_pressed("add_fire") and $Particles.emitting == false:
		$Particles.texture = fireTexture
		$Particles.emitting = true
		isWater = false
	
	$EffectArea.monitoring = $Particles.emitting

	move_and_slide()
