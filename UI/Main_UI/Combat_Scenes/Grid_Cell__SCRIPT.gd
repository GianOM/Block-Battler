class_name Canvas_Grid_Cell extends Panel

signal Player_Hovering_Cell
signal Player_Unhovered_Cell



func _on_Mouse_ENTER_Hitbox():
	
	
	Player_Hovering_Cell.emit(self)
	
	
func _on_Mouse_LEAVE_Hitbox():
	
	
	Player_Unhovered_Cell.emit(self)
	
	
	
