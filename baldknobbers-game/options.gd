extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HSlider.value = Globals.volume_
	$Sound.text = "Volume " + str(int($HSlider.value)) + "%"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	Globals.save_data()
	get_tree().change_scene_to_file("res://Title.tscn")
	

func _on_h_slider_value_changed(value: float) -> void:
	Globals.volume_ = value
	AudioServer.set_bus_volume_linear(0,value/100.0)
	$Sound.text = "Volume " + str(int($HSlider.value)) + "%"
