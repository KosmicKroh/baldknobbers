extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$SkinButtons/Skin2.disabled = !Globals.endings[0]
	$SkinButtons/Skin3.disabled = !Globals.endings[1]
	$SkinButtons/Skin4.disabled = !Globals.endings[2]
	$SkinButtons/Skin5.disabled = !Globals.endings[3]
	if ($SkinButtons/Skin2.disabled or $SkinButtons/Skin3.disabled or $SkinButtons/Skin4.disabled or $SkinButtons/Skin5.disabled):
		$SkinButtons/Skin6.disabled = true
	else:
		$SkinButtons/Skin6.disabled = false
	for button in $SkinButtons.get_child_count():
		if Globals.skin == button:
			$SkinButtons.get_child(button).scale = Vector2(1.5,1.5)
			$SkinButtons.get_child(button).rotation += delta*3.0
		else:
			$SkinButtons.get_child(button).scale = Vector2(1.0,1.0)
			$SkinButtons.get_child(button).rotation -= $SkinButtons.get_child(button).rotation*0.1
			$SkinButtons.get_child(button).rotation = fmod($SkinButtons.get_child(button).rotation,PI*2)


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_game.tscn")

func _on_option_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Options.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_skin_button_pressed(skin_choice: int) -> void:
	Globals.skin = skin_choice
	Globals.save_data()
