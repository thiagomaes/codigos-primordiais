extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false

func _on_button_pressed():
	LevelManager.load_new_level("res://Scenes/playground.tscn", "", Vector2.ZERO)

func _on_button_2_pressed():
	pass

func _on_button_3_pressed():
	get_tree().quit()
