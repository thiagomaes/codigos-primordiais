extends Node

signal mission_started
signal mission_completed
signal mission_failed

var active: bool = false
var comprimento: int = 0
var largura: int = 0
var area_placa: int = 0
var area_ponte: int = 0
var quantidade_placas: int = 0
var current_level: int = 1

const LEVELS = {
	1: "res://levels/area01/01.tscn",
	2: "res://levels/area01/02.tscn",
	3: "res://levels/area01/03.tscn"
}

func generate_mission() -> void:
	comprimento = randi_range(4, 12)
	largura = randi_range(2, 6)
	area_placa = randi_range(2, 6)
	area_ponte = comprimento * largura
	quantidade_placas = ceili(float(area_ponte) / float(area_placa))
	active = true
	mission_started.emit()

func complete_mission() -> void:
	active = false
	mission_completed.emit()

func fail_mission() -> void:
	active = false
	mission_failed.emit()

func get_current_level_path() -> String:
	return LEVELS.get(current_level, LEVELS[1])

func advance_level() -> void:
	# Agora o nível pode chegar a 4, ativando o final do jogo na Guia!
	if current_level <= LEVELS.size():
		current_level += 1

func get_dialog_text() -> Array[String]:
	var lines: Array[String] = []
	
	# Se for a PRIMEIRA vez que o jogador fala com ele (Nível 1)
	if current_level == 1:
		lines.append("Olá, aventureiro!")
		lines.append("Estou tentando terminar a construção da minha casa, mas travei em uma etapa.")
	# Se for o Nível 2 ou 3 (Ele já te ajudou antes, então agradecemos!)
	else:
		lines.append("Ah, você voltou! Muito obrigado por ter resolvido os cálculos da área anterior.")
		lines.append("Graças a você, consegui avançar bastante na construção da casa!")
		lines.append("Porém, me deparei com um novo problema...")

	# O resto do texto serve para qualquer um dos níveis
	lines.append("Os próximos materiais também estão me deixando maluco!")
	lines.append("Você poderia me dar mais uma mãozinha com isso?")
	lines.append("Por favor, vá até a bancada de trabalho na Área %d." % current_level)
	lines.append("Conto com a sua ajuda!")
	
	return lines
