extends StaticBody2D

# Essa variável vai aparecer no Inspetor para você definir qual área isso bloqueia
@export var nivel_da_area: int = 3

func _ready() -> void:
	# 1. Verifica se já deve estar liberado assim que o mapa carregar
	checar_liberacao()
	
	# 2. Fica "escutando" a Guia. Quando ela gerar a missão, checa novamente!
	MissionManager.mission_started.connect(checar_liberacao)

func checar_liberacao() -> void:
	# A barreira deve sumir se o jogador já completou esse nível no passado,
	# ou se ele está neste nível exato e a missão acabou de ser ativada pela Guia.
	if MissionManager.current_level > nivel_da_area or (MissionManager.current_level == nivel_da_area and MissionManager.active):
		queue_free() # Destrói a barreira e libera a passagem
