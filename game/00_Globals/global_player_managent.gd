extends Node

const JOGADOR = preload("res://Scenes/jogador.tscn")
var player : Player # Opcional: Se 'Player' der erro de tipagem no futuro, mude para 'CharacterBody2D'
var player_spawned : bool = false

func _ready() -> void:
	pass

func add_player_instance() -> void:
	# Antes de criar, verifica se JÁ existe um jogador vivo para não clonar
	if player and is_instance_valid(player):
		return
		
	player = JOGADOR.instantiate()
	player_spawned = false # <-- ESSA É A MÁGICA! Reseta o status para a nova partida
	add_child(player)

func set_player_position(_new_pos: Vector2) -> void:
	if player and is_instance_valid(player):
		player.global_position = _new_pos

func set_as_parent(_p: Node2D) -> void:
	# 1. Se o jogador foi destruído junto com a fase antiga, recriamos ele aqui!
	if not is_instance_valid(player):
		add_player_instance()
		
	# 2. Faz a troca de pais com total segurança
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)

func unparent_player(_p: Node2D) -> void:
	if player and is_instance_valid(player) and player.get_parent() == _p:
		_p.remove_child(player)
