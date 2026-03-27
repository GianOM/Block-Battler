extends MeshInstance3D


func _ready() -> void:
	GlobalMap.Traverse_Player_Icon_to_Room3D.connect(move_player_icon_to_room)
	
	
	
func move_player_icon_to_room(room_target: Room3D):
	global_position = room_target.global_position
	global_position.y += 2
