extends Node

#region EnemyEncounters
@warning_ignore("unused_signal")
signal Player_Entered_NormalEnemy_Room
@warning_ignore("unused_signal")
signal Player_Entered_MiniBoss_Room
@warning_ignore("unused_signal")
signal Player_Entered_FinalBoss_Room
#endregion



@warning_ignore("unused_signal")
signal Player_Entered_Shop_Room
signal shop_exited
@warning_ignore("unused_signal")
signal Player_Entered_Rest_Room
signal rest_site_exited
@warning_ignore("unused_signal")
signal Player_Entered_RandomEncounter_Room
signal random_encounter_exited

signal combat_reward_exited

#needs to send;receive room type
signal go_to_room(room_target: Room3D)


var current_hovered_room3d: Array[Room3D]


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if current_hovered_room3d.size() > 0 :
				
				var Temp_Room: Room3D = current_hovered_room3d[-1]
				
				if Temp_Room.is_reachable:
					go_to_room.emit(current_hovered_room3d[-1])



func Set_Currently_Hovered_Room_3d(room_3d_hovered: Room3D):
	current_hovered_room3d.push_back(room_3d_hovered)
	
func RESET_Hovered_Room3D(room_3d_unhovered: Room3D):
	current_hovered_room3d.erase(room_3d_unhovered)
