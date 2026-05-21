class_name State_Idle extends State

@onready var walk : State = $"../Walk"

func Enter() -> void:
	var dir = player.cardinal_direction
	if dir == Vector2.DOWN:
		player.SetAnimation("idle_front")
	elif dir == Vector2.UP:
		player.SetAnimation("idle_back")
	elif dir == Vector2.LEFT:
		player.SetAnimation("idle_left")
	else:
		player.SetAnimation("idle_right")

func Exit() -> void:
	pass


func Process(_delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

func Physics(_delta : float) -> State:
	return null

func HandleInput(_event: InputEvent) -> State:
	return null
