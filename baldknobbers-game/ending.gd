extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	$EndSound.play()
	$Label.visible_ratio = 0
	if name != "ending_1":
		await get_tree().create_timer(1.0).timeout
		$EndSound.play()
		await get_tree().create_timer(1.0).timeout
		$EndSound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.visible_ratio += delta*0.2


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://Title.tscn")
