extends Node



func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton :
		
		# Solta o Botao Direito
		if (event.button_index == MOUSE_BUTTON_LEFT) and event.is_pressed():
			JOGADOR.Left_Click_Pressed.emit()
			
			
		# Solta o Botao Esquerdo
		elif (event.button_index == MOUSE_BUTTON_LEFT) and event.is_released():
			JOGADOR.Left_Click_Released.emit()
		
		
