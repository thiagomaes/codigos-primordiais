extends CharacterBody2D

@onready var interact_label: Label = $Label
var dialog_box: Node = null
var player_nearby: bool = false

func _ready() -> void:
	interact_label.visible = false
	dialog_box = get_tree().get_first_node_in_group("dialog_box")

func _input(event: InputEvent) -> void:
	if not player_nearby:
		return
	if not event.is_action_pressed("interact"):
		return
	if dialog_box == null or dialog_box.visible:
		return
	get_viewport().set_input_as_handled()
	open_dialog()

func open_dialog() -> void:
	if dialog_box == null:
		push_error("DialogBox não encontrada!")
		return
		
	# Trava o movimento do jogador
	get_tree().call_group("jogador", "set_can_move", false)
	
	# Diálogo de jogo finalizado (Todas as missões completas)
	if MissionManager.current_level > MissionManager.LEVELS.size():
		dialog_box.start([
			"Muito bem, aventureiro!",
			"As pontes voltaram a funcionar perfeitamente.",
			"Agradeço imensamente pela sua ajuda."
		], "Guia")
		dialog_box.dialog_finished.connect(_on_game_finished, CONNECT_ONE_SHOT)
		return
		
	# Diálogo de aviso (Missão já está ativa)
	if MissionManager.active:
		dialog_box.start([
			"Você ainda tem uma tarefa pendente.",
			"Verifique a área indicada e conclua o conserto."
		], "Guia")
		dialog_box.dialog_finished.connect(_on_warning_dialog_finished, CONNECT_ONE_SHOT)
		return
		
	# Diálogo de nova missão
	MissionManager.generate_mission()
	dialog_box.start(MissionManager.get_dialog_text(), "Guia")
	dialog_box.dialog_finished.connect(_on_dialog_finished, CONNECT_ONE_SHOT)

func _on_warning_dialog_finished() -> void:
	# Libera o jogador após o aviso
	get_tree().call_group("jogador", "set_can_move", true)

func _on_dialog_finished() -> void:
	# Libera o jogador ao fim do diálogo da nova missão e ativa a seta
	get_tree().call_group("jogador", "set_can_move", true)
	get_tree().call_group("mission_arrow", "activate")

func _on_game_finished() -> void:
	LevelManager.load_new_level("res://Scenes/creditos.tscn", "", Vector2.ZERO)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		player_nearby = true
		interact_label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		player_nearby = false
		interact_label.visible = false
