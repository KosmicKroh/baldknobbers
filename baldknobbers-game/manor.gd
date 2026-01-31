extends Node2D

signal loaded

var roomScenes = [
	load("res://room_bath.tscn"),
	load("res://room_hallway.tscn"),
	load("res://room_lounge.tscn"),
	load("res://room_kitchen.tscn"),
	load("res://room_foyer.tscn"),
	load("res://room_bedroom.tscn")
]
var closedExit = load("res://closed_exit.tscn")
@export var manorSize:int = 50
var roomsPlaced:int = 0
var newExitIndex = 0
var availableExits = []
var woodPiles = []
var started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for exit in $Origin/Exits.get_children():
		availableExits.append(exit)
		
	
	
func close_exits() -> void:
	for i in availableExits:
		var newClose = closedExit.instantiate()
		newClose.global_transform = i.global_transform
		newClose.rotation += PI
		add_child(newClose)
	woodPiles.shuffle()
	for i in manorSize:
		woodPiles[i].on = 1
	Globals.fireCount = manorSize
	loaded.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Check for Overlapping Room
	if started and roomsPlaced < manorSize:
		var lastRoom:Node2D = get_child(get_child_count()-1)
		if lastRoom.find_child("Hitbox").has_overlapping_areas() or lastRoom.global_position.y >= $Origin.position.y-50:
			lastRoom.queue_free()
		else:
			roomsPlaced += 1
			woodPiles.append(lastRoom.find_child("WoodPiles").get_child(0))
			woodPiles.append(lastRoom.find_child("WoodPiles").get_child(1))
			availableExits.remove_at(newExitIndex)
			for exit in lastRoom.find_child("Exits").get_children():
				availableExits.append(exit)
			if (roomsPlaced >= manorSize):
				close_exits()
				
	if roomsPlaced < manorSize:
		var newRoom:Node2D = roomScenes.pick_random().instantiate()
		newExitIndex = randi_range(0,len(availableExits)-1)
		var newExit = availableExits[newExitIndex]
		var newEntrance = newRoom.find_child("Exits").get_children().pick_random()
		newRoom.global_transform = newExit.global_transform
		newRoom.rotation += PI-newEntrance.rotation
		newRoom.global_position += (newExit.global_position - newEntrance.global_position)
		newRoom.find_child("Exits").remove_child(newEntrance)
		add_child(newRoom)
		started = true
		
	
	
