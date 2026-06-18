extends CanvasLayer

@onready var arrow: TextureRect = $TextureRect

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

	# Cria textura de flecha
	var image = Image.create(16, 16, false, Image.FORMAT_RGBA8)
	image.fill(Color(0, 0, 0, 0))
	for i in range(8):
		image.set_pixel(i, 7, Color.YELLOW)
		image.set_pixel(i, 8, Color.YELLOW)
	for i in range(5):
		image.set_pixel(8 + i, 7 - i, Color.YELLOW)
		image.set_pixel(8 + i, 8 + i, Color.YELLOW)
	arrow.texture = ImageTexture.create_from_image(image)
	arrow.size = Vector2(16, 16)
	arrow.pivot_offset = Vector2(8, 8)

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
	var dir = target.global_position - player.global_position
	arrow.rotation = dir.angle()
	var screen_center = get_viewport().get_visible_rect().size / 2.0
	arrow.position = screen_center + dir.normalized() * 50
