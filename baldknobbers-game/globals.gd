extends Node

var fireCount:int = 0
var timer = 0
var timerEnabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fireCount = 0

func loadEnding(ending:int):
	timerEnabled = false
	match ending:
		1: get_tree().change_scene_to_file("res://ending_1.tscn")
		2: get_tree().change_scene_to_file("res://ending_2.tscn")
		3: get_tree().change_scene_to_file("res://ending_3.tscn")
		4: get_tree().change_scene_to_file("res://ending_4.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timerEnabled:
		if fireCount == 0:
			loadEnding(1)
		elif fireCount >= 100:
			loadEnding(2)
		if timer > 0:
			timer -= delta*fireCount/50.0
		else:
			loadEnding(3)
			
			
			
