extends CanvasLayer

signal answer_selected(correct: bool)

@onready var question_label: Label = $Control/VBoxContainer/Label
@onready var btn_a: Button = $Control/VBoxContainer/Button
@onready var btn_b: Button = $Control/VBoxContainer/Button2
@onready var btn_c: Button = $Control/VBoxContainer/Button3

var correct_answer: int = 0

func _ready() -> void:
	visible = false
	btn_a.pressed.connect(_on_answer_pressed.bind(0))
	btn_b.pressed.connect(_on_answer_pressed.bind(1))
	btn_c.pressed.connect(_on_answer_pressed.bind(2))

func show_question(options: Array, correct_index: int) -> void:
	correct_answer = correct_index
	question_label.text = "Quantas placas são necessárias?"
	btn_a.text = "A) %d placas" % options[0]
	btn_b.text = "B) %d placas" % options[1]
	btn_c.text = "C) %d placas" % options[2]
	
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Pausa o jogo assim que a pergunta aparece (bloqueia movimento do jogador e inimigos)
	get_tree().paused = true 

func _on_answer_pressed(index: int) -> void:
	visible = false
	
	# Despausa o jogo assim que uma resposta é clicada
	get_tree().paused = false 
	
	if index == correct_answer:
		answer_selected.emit(true)
	else:
		answer_selected.emit(false)
