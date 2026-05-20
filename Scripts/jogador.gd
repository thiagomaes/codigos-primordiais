class_name Jogador extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var state : String = "idle"
var move_speed : float = 100.0

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("idle_front")

func _process(delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if direction != Vector2.ZERO:
		cardinal_direction = direction.normalized()
		velocity = direction * move_speed
		
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				state = "walk_right"
			else:
				state = "walk_left"
		else:
			if direction.y > 0:
				state = "walk_front"
			else:
				state = "walk_back"
	else:
		velocity = Vector2.ZERO
		state = state.replace("walk_", "idle_").replace("run_", "idle_")
	
	anim.play(state)

func _physics_process(delta):
	move_and_slide()
