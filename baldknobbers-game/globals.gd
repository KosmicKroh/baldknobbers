extends Node

var fireCount:int = 0
var timer = 0
var timerEnabled = false
var volume_ = 70
var endings = [false,false,false,false]
var played = false

# Config & Endings
func load_data():
	var config = ConfigFile.new()
	var err = config.load("user://baldknobbers.cfg")
	if err != OK:
		return
	volume_ = config.get_value("Options","Volume",70)
	endings[0] = config.get_value("Endings","1st",false)
	endings[1] = config.get_value("Endings","2nd",false)
	endings[2] = config.get_value("Endings","3rd",false)
	endings[3] = config.get_value("Endings","4th",false)
	
func save_data():
	var config = ConfigFile.new()
	config.set_value("Options","Volume",volume_)
	config.set_value("Endings","1st",endings[0])
	config.set_value("Endings","2nd",endings[1])
	config.set_value("Endings","3rd",endings[2])
	config.set_value("Endings","4th",endings[3])
	config.save("user://baldknobbers.cfg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fireCount = 0
	load_data()
	AudioServer.set_bus_volume_linear(0,volume_/100.0)

func loadEnding(ending:int):
	timerEnabled = false
	Globals.endings[ending-1] = true
	Globals.save_data()
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
			
			
			
