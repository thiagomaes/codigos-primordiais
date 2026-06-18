class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var can_move : bool = true # <--- 1. NOVA VARIÁVEL AQUI

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

func _ready() -> void:
	state_machine.Initialize(self)

func _process(delta):
	# <--- 2. VERIFICAÇÃO DA TRAVA
	if not can_move:
		direction = Vector2.ZERO
		return
		
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
	if direction != Vector2.ZERO:
		cardinal_direction = direction

func _physics_process(delta):
	move_and_slide()

func SetAnimation(anim_name : String) -> void:
	anim.play(anim_name)

# <--- 3. NOVA FUNÇÃO PARA ALTERAR A TRAVA DE FORA DO SCRIPT
func set_can_move(value: bool) -> void:
	can_move = value
