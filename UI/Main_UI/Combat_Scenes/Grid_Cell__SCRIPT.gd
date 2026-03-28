class_name Canvas_Grid_Cell extends Panel

signal Player_Hovering_Cell
signal Player_Unhovered_Cell


@onready var canvas_grid_cell_hitbox: Area2D = $Canvas_Grid_Cell_HITBOX


func Disable_Canvas_Slot():
	canvas_grid_cell_hitbox.hide()
func Enable_Canvas_Slot():
	canvas_grid_cell_hitbox.show()




func _on_Mouse_ENTER_Hitbox():
	
	
	Player_Hovering_Cell.emit(self)
	
	
func _on_Mouse_LEAVE_Hitbox():
	
	
	Player_Unhovered_Cell.emit(self)
	
	
	
