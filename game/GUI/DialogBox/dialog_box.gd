extends CanvasLayer

signal dialog_finished

@onready var text_label: RichTextLabel = $Control/Panel/MarginContainer/VBoxContainer/RichTextLabel
@onready var name_label: Label = $Control/Panel/MarginContainer/VBoxContainer/Label
@onready var continue_label: Label = $Control/Panel/ContinueLabel

var lines: Array = []
var current_line: int = 0
var is_typing: bool = false
var full_text: String = ""
var skip_typing: bool = false

func _ready() -> void:
	visible = false

func start(dialog_lines: Array, speaker_name: String = "NPC") -> void:
	lines = dialog_lines
	current_line = 0
	name_label.text = speaker_name
	visible = true
	show_line()

func show_line() -> void:
	full_text = lines[current_line]
	text_label.text = ""
	continue_label.visible = false
	skip_typing = false
	is_typing = true
	type_text()

func type_text() -> void:
	for i in full_text.length():
		if skip_typing:
			break
		text_label.text += full_text[i]
		await get_tree().create_timer(0.03).timeout
	# Garante que o texto completo aparece e marca como terminado
	text_label.text = full_text
	is_typing = false
	skip_typing = false
	continue_label.visible = true

func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()
		print("is_typing: ", is_typing, " | current_line: ", current_line, " | lines.size(): ", lines.size())
		if is_typing:
			skip_typing = true
			is_typing = false
			text_label.text = full_text
			continue_label.visible = true
		else:
			current_line += 1
			print("Avançando para linha: ", current_line)
			if current_line >= lines.size():
				print("Fechando dialogo!")
				visible = false
				dialog_finished.emit()
			else:
				show_line()
				
				
