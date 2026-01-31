extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HSlider.value = Globals.volume_
	$Sound.text = "Volume " + str(int(((Globals.volume_+80)/104)*100)) + " %"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Title.tscn")
	

func _on_h_slider_value_changed(value: float) -> void:
	Globals.volume_ = value
	$Sound.text = "Volume " + str(int(((Globals.volume_+80)/104)*100)) + " %"
