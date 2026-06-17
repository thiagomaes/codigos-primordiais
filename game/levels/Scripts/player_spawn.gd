extends Node2D

func _ready() -> void:
	visible = false
	if PlayerManager.player_spawned == false:
		PlayerManager.add_player_instance()
		await get_tree().process_frame
		PlayerManager.set_player_position(global_position)
		PlayerManager.player_spawned = true
