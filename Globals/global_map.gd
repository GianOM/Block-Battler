extends Node


signal Traverse_Player_Icon_to_Room3D(room_target: Room3D)


var current_hovered_room3d: Array[Room3D]


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if current_hovered_room3d.size() > 0 :
				Traverse_Player_Icon_to_Room3D.emit(current_hovered_room3d[-1])



func Set_Currently_Hovered_Room_3d(room_3d_hovered: Room3D):
	current_hovered_room3d.push_back(room_3d_hovered)
	
func RESET_Hovered_Room3D(room_3d_unhovered: Room3D):
	current_hovered_room3d.erase(room_3d_unhovered)
