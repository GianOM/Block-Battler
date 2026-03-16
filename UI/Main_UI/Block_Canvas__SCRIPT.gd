extends Control





func _on_Mouse_Entered_Canvas():
	
	JOGADOR.Set_Block_Dropable()
	
	
	
func _on_Mouse_Leave_Canvas():
	
	JOGADOR.Set_Block_Dragging()
	
