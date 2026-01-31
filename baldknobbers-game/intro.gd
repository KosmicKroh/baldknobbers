extends Control

var onText:int = 0
var introTimer = 10.0
var loaded = false
signal done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panels.frame = 0
	Globals.timer = 400.0
	$Label.text = "Your name is Frank Mease. You are a fire fighter from Galena, Missouri. While on patrol, you noticed a cloth mask lying on a felled oak. You put on the mask…. It guides you."
	$SkipReady.visible = false
	loaded = false

func next_text():
	onText += 1
	$Label.visible_ratio = 0
	match onText:
		1:
			$Panels.frame = 1
			$Label.text = "You enter into Taney county and notice a raid occurring on the Mayor of Branson's Manor… compelled by the mask, you enter the manor… did it bring you here to stop the raid? Or finish it?"
		2:
			done.emit()
			queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	introTimer -= delta
	if introTimer > 0:
		$Label.visible_ratio += delta/5.0
	else:
		introTimer = 10.0
		next_text()
	if loaded:
		$SkipReady.visible = true
		if Input.is_action_just_pressed("ui_accept"):
			done.emit()
			queue_free()
		
