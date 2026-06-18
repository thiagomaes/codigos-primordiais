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
	var lines: Array[String] = [
		"Olá, aventureiro!",
		"Preciso da sua ajuda para consertar a ponte.",
		"A abertura tem %d metros de comprimento" % comprimento,
		"por %d metros de largura." % largura,
		"Cada placa cobre %d metros quadrados." % area_placa,
		"Quantas placas precisamos?",
		"Siga a seta até a área %d e faça o conserto!" % current_level # <--- O truque está aqui!
	]
	return lines
