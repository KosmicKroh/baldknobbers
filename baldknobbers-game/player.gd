extends CharacterBody2D


const SPEED = 300.0
var waterTexture = load("res://Sprites/WaterDrop.png")
var fireTexture = load("res://Sprites/Fireball.png")
var isWater:bool = true
var emitTimer = 0.0


func _physics_process(delta: float) -> void:
	emitTimer -= delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX := Input.get_axis("walk_left", "walk_right")
	var directionY := Input.get_axis("walk_up", "walk_down")
	
	if directionX or directionY:
		if Globals.timerEnabled == false:
			Globals.timer = 400.0
			Globals.timerEnabled = true
		velocity += (Vector2(directionX,directionY).normalized()*SPEED-velocity)*0.1
		if directionX == 1:
			rotation = 0
		elif directionX == -1:
			rotation = PI
		elif directionY == 1:
			rotation = PI/2
		elif directionY == -1:
			rotation = -PI/2
	else:
		velocity *= 0.93
	
	if Input.is_action_pressed("add_water"):
		$Particles.texture = waterTexture
		$Particles.emitting = true
		isWater = true
		$EffectArea.monitoring = true
	elif Input.is_action_pressed("add_fire"):
		$Particles.texture = fireTexture
		$Particles.emitting = true
		isWater = false
		$EffectArea.monitoring = true
	else:
		$EffectArea.monitoring = false
		$Particles.emitting = false
	
	if $EffectArea.monitoring:
		for thing in $EffectArea.get_overlapping_areas():
			if "isWood" in thing:
				if isWater and thing.on:
					thing.on = false
					Globals.fireCount -= 1
				if !isWater and !thing.on:
					thing.on = true
					Globals.fireCount += 1

	move_and_slide()
