class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle : State = $"../Idle"

func Enter() -> void:
	var dir = player.cardinal_direction
	if dir == Vector2.DOWN:
		player.SetAnimation("walk_front")
	elif dir == Vector2.UP:
		player.SetAnimation("walk_back")
	elif dir == Vector2.LEFT:
		player.SetAnimation("walk_left")
	else:
		player.SetAnimation("walk_right")

func Exit() -> void:
	pass

func Process(_delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	var dir = player.cardinal_direction
	if dir == Vector2.DOWN:
		player.SetAnimation("walk_front")
	elif dir == Vector2.UP:
		player.SetAnimation("walk_back")
	elif dir == Vector2.LEFT:
		player.SetAnimation("walk_left")
	else:
		player.SetAnimation("walk_right")
	
	return null

func Physics(_delta : float) -> State:
	return null

func HandleInput(_event: InputEvent) -> State:
	return null
