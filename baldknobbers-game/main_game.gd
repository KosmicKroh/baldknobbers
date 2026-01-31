extends Node2D

var controlTimer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/Collider.disabled = true
	$Player/PlayerCamera.enabled = false
	controlTimer = 0
	$Controls.visible = false
	$Scoreboard.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if controlTimer > 0:
		$Scoreboard.visible = true
		$Controls.visible = true
		$Controls/Modulate.color = Color(1.0,1.0,1.0,min(controlTimer*0.5,1.0))
		controlTimer -= delta
	else:
		$Controls.visible = false
	if Globals.timer < 50:
		if $Music.playing:
			$Music.stop()
			$FastMusic.play()
		for body in $Entrance.get_overlapping_bodies():
			if "isPlayer" in body:
				Globals.loadEnding(4)


func _on_intro_done() -> void:
	$Music.play()
	$Player/Collider.disabled = false
	$Player/PlayerCamera.enabled = true
	controlTimer = 10.0
	Globals.played = true


func _on_manor_loaded() -> void:
	$Intro.loaded = true
