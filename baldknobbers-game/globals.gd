extends Node

var fireCount:int = 0
var timer = 0
var timerEnabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fireCount = 0

func loadEnding():
	timerEnabled = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timerEnabled:
		if timer > 0:
			timer -= delta*fireCount/50.0
		else:
			loadEnding()
			
			
			
