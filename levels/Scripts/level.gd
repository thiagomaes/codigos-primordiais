class_name Level extends Node2D

func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	
	# A conexão vem para o _ready()!
	# Assim que o level carregar, ele fica esperando o sinal do LevelManager.
	LevelManager.level_load_started.connect( _free_level )
	
func _free_level() -> void:
	PlayerManager.unparent_player( self )
	# Tiramos a linha do connect daqui, e deixamos só o desapego e o queue_free!
	queue_free()
