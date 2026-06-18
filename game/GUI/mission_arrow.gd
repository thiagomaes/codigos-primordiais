extends CanvasLayer

@onready var arrow: Sprite2D = $Sprite2D

var target: Node2D = null

const TRANSITION_NAMES = {
	1: "LevelTransition",
	2: "LevelTransition2",
	3: "LevelTransition3"
}

func _ready() -> void:
	add_to_group("mission_arrow")
	visible = false
	MissionManager.mission_completed.connect(deactivate)
	MissionManager.mission_failed.connect(deactivate)

func activate() -> void:
	var level = MissionManager.current_level
	var transition_name = TRANSITION_NAMES.get(level, "LevelTransition")
	target = get_tree().get_current_scene().get_node_or_null(transition_name)
	if target == null:
		push_error("LevelTransition não encontrada: " + transition_name)
	visible = true

func deactivate() -> void:
	visible = false
	target = null

func _process(_delta: float) -> void:
	if not visible or target == null:
		return
		
	var player = get_tree().get_first_node_in_group("jogador")
	if player == null:
		return
		
	# Calcula a direção do jogador até a transição de fase
	var dir = target.global_position - player.global_position
	
	# COMPENSAÇÃO DE ROTAÇÃO: 
	# Soma PI / 2.0 (90 graus) porque o desenho original da flecha aponta para cima
	arrow.rotation = dir.angle() + (PI / 2.0)
	
	# Posiciona a flecha ao redor do centro da tela
	var screen_center = get_viewport().get_visible_rect().size / 2.0
	
	# Como o Sprite2D já está centralizado (Centered = Ativo), aplicamos direto:
	arrow.position = screen_center + (dir.normalized() * 50)
