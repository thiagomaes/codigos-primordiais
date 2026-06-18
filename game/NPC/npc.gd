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
	if MissionManager.active:
		dialog_box.start(["Você já tem uma missão ativa!", "Vá até a área 1."], "Velhinho")
		return
	MissionManager.generate_mission()
	dialog_box.start(MissionManager.get_dialog_text(), "Velhinho")
	dialog_box.dialog_finished.connect(_on_dialog_finished, CONNECT_ONE_SHOT)

func _on_dialog_finished() -> void:
	get_tree().call_group("mission_arrow", "activate")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		player_nearby = true
		interact_label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		player_nearby = false
		interact_label.visible = false
