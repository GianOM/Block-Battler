class_name Canvas_Grid_Cell extends Panel

signal Player_Hovering_Cell




func _on_Mouse_ENTER_Hitbox():
	
	
	Player_Hovering_Cell.emit(self)
	
	pass
	
	
func _on_Mouse_LEAVE_Hitbox():
	pass
