extends Area2D

var isWood:bool = true
var on = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on = randi()%2
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if on:
		$Sprites.play("on")
	else:
		$Sprites.play("off")
