extends MeshInstance3D


func _ready() -> void:
	GlobalMap.go_to_room.connect(move_player_icon_to_room)
	
	
	
func move_player_icon_to_room(room_target: Room3D):
	global_position = room_target.global_position
	global_position.y += 2
