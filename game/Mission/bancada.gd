extends StaticBody2D

@onready var interact_label: Label = $Label
var dialog_box: Node = null
var player_nearby: bool = false

func _ready() -> void:
	interact_label.visible = false
	dialog_box = get_tree().get_first_node_in_group("dialog_box")

func get_answer_box() -> Node:
	var ab = get_tree().get_first_node_in_group("answer_box")
	if ab == null:
		push_error("AnswerBox não encontrada!")
	return ab

func _input(event: InputEvent) -> void:
	if not player_nearby:
		return
	if not event.is_action_pressed("interact"):
		return
	if not MissionManager.active:
		return
	if dialog_box == null or dialog_box.visible:
		return
	get_viewport().set_input_as_handled()
	show_mission_question()

func show_mission_question() -> void:
	var placas = MissionManager.quantidade_placas
	var errado1 = placas + randi_range(1, 3)
	var errado2 = placas - randi_range(1, 3)
	if errado2 <= 0:
		errado2 = placas + randi_range(4, 6)
	dialog_box.start([
		"A ponte tem %d metros de comprimento" % MissionManager.comprimento,
		"por %d metros de largura." % MissionManager.largura,
		"Área: %d x %d = %d m²" % [MissionManager.comprimento, MissionManager.largura, MissionManager.area_ponte],
		"Cada placa cobre %d m²." % MissionManager.area_placa,
		"Quantas placas são necessárias?"
	], "Bancada")
	dialog_box.dialog_finished.connect(
		func():
			var ab = get_answer_box()
			if ab == null:
				return
			ab.answer_selected.connect(_on_answer_result, CONNECT_ONE_SHOT)
			ab.show_question([placas, errado1, errado2], 0),
		CONNECT_ONE_SHOT
	)

func _on_answer_result(correct: bool) -> void:
	if correct:
		_on_answer_correct()
	else:
		_on_answer_wrong()

func _on_answer_correct() -> void:
	MissionManager.complete_mission()
	MissionManager.advance_level()
	dialog_box.start(["Correto! Volte ao Velhinho para a próxima missão!"], "Bancada")

func _on_answer_wrong() -> void:
	MissionManager.fail_mission()
	dialog_box.start(["Errado! Volte ao Velhinho para uma nova missão."], "Bancada")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		player_nearby = true
		interact_label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		player_nearby = false
		interact_label.visible = false
