extends CanvasLayer

@onready var fundo_escuro = $ColorRect

# Contêineres
@onready var container_botoes = $VBoxContainer
@onready var menu_opcoes = $MenuOpcoes

# Botões do Menu Principal
@onready var btn_voltar = $VBoxContainer/BtnVoltar
@onready var btn_opcoes = $VBoxContainer/BtnOpcoes
@onready var btn_sair = $VBoxContainer/BtnSair

# Botão de Voltar das Opções
@onready var btn_voltar_opcoes = $MenuOpcoes/BtnVoltarOpcoes

func _ready() -> void:
	hide() 
	
	# Conecta os botões principais
	btn_voltar.pressed.connect(_on_voltar_pressed)
	btn_opcoes.pressed.connect(_on_opcoes_pressed)
	btn_sair.pressed.connect(_on_sair_pressed)
	
	# Conecta o botão de voltar do painel de opções
	btn_voltar_opcoes.pressed.connect(_on_voltar_opcoes_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		var cena_atual = get_tree().current_scene.name.to_lower()
		if "main_menu" in cena_atual or "mainmenu" in cena_atual:
			return 
			
		if get_tree().paused and not visible:
			return
			
		toggle_pause()

func toggle_pause() -> void:
	visible = !visible
	get_tree().paused = visible
	
	if visible:
		# Sempre que abrir o menu pelo ESC, garante que mostra a tela inicial dele
		container_botoes.show()
		menu_opcoes.hide()

func _on_voltar_pressed() -> void:
	toggle_pause()

func _on_opcoes_pressed() -> void:
	# Esconde os botões principais e mostra os sliders de áudio
	container_botoes.hide()
	menu_opcoes.show()

func _on_voltar_opcoes_pressed() -> void:
	# Faz o inverso: esconde as opções e volta pros botões principais do pause
	menu_opcoes.hide()
	container_botoes.show()

func _on_sair_pressed() -> void:
	get_tree().paused = false 
	hide()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
