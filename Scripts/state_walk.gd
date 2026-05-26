class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle : State = $"../Idle"

func Enter() -> void:
	UpdateAnim()

func Exit() -> void:
	pass

func Process(_delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	UpdateAnim()
	return null

func Physics(_delta : float) -> State:
	return null

func HandleInput(_event: InputEvent) -> State:
	return null

func UpdateAnim() -> void:
	var dir = player.cardinal_direction
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			player.SetAnimation("walk_right")
		else:
			player.SetAnimation("walk_left")
	else:
		if dir.y > 0:
			player.SetAnimation("walk_front")
		else:
			player.SetAnimation("walk_back")
