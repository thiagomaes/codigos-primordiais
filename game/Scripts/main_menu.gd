extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false
	show_main_menu()

func show_main_menu() -> void:
	main_buttons.visible = true
	options.visible = false

func _on_button_pressed():
	LevelManager.load_new_level("res://Scenes/playground.tscn", "", Vector2.ZERO)

func _on_button_2_pressed():
	main_buttons.visible = false
	options.visible = true

func _on_button_3_pressed():
	get_tree().quit()

func _on_back_pressed() -> void:
	show_main_menu()
