extends Area3D

@export var Room3D_Root: Room3D



func _on_Player_Mouse_Enter_Area():
	
	Room3D_Root.On_Mouse_Hover()
	GlobalMap.Set_Currently_Hovered_Room_3d(Room3D_Root)
	
	
func _on_Player_Mouse_Leave_Area():
	
	
	Room3D_Root.On_Mouse_UnHover()
	
	GlobalMap.RESET_Hovered_Room3D(Room3D_Root)
