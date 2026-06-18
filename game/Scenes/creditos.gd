extends Control

var saindo_da_tela: bool = false # Nossa variável de trava

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false
	$Timer.start() # Dica: você também pode apenas marcar "Autostart" no Inspector do Timer

func _on_timer_timeout() -> void:
	voltar_para_menu()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") or event.is_action_pressed("ui_accept"):
		voltar_para_menu()

# Criamos uma função única para não repetir código
func voltar_para_menu() -> void:
	if saindo_da_tela == false:
		saindo_da_tela = true # Ativa a trava
		LevelManager.load_new_level("res://Scenes/main_menu.tscn", "", Vector2.ZERO)
