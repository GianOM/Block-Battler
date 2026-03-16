extends Control


var is_mouse_on_Canvas: bool = false



func _on_Mouse_Entered_Canvas():
	
	is_mouse_on_Canvas = true
	
	JOGADOR.Player_Mouse_Entered_Canvas.emit()
	
	
	
func _on_Mouse_Leave_Canvas():
	
	is_mouse_on_Canvas = false
	
	JOGADOR.Player_Mouse_Left_Canvas.emit()
	
