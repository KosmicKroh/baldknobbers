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
	
	if Input.is_action_just_pressed("add_water") and emitTimer <=0:
		$Particles.texture = waterTexture
		$Particles.emitting = true
		isWater = true
		emitTimer = 0.5
		$EffectArea.monitoring = true
		
	if Input.is_action_just_pressed("add_fire") and emitTimer <=0:
		$Particles.texture = fireTexture
		$Particles.emitting = true
		isWater = false
		emitTimer = 0.5
		$EffectArea.monitoring = true
	
	if emitTimer < 0:
		$EffectArea.monitoring = false
	
	if $EffectArea.monitoring:
		for thing in $EffectArea.get_overlapping_areas():
			if "isWood" in thing:
				if isWater and thing.on:
					thing.on = false
					Globals.fireCount -= 1
				if !isWater and !thing.on:
					thing.on = true
					Globals.fireCount += 1
				print(Globals.fireCount)

	move_and_slide()
