extends Node

#region EnemyEncounters
@warning_ignore("unused_signal")
signal Player_Entered_NormalEnemy_Room
@warning_ignore("unused_signal")
signal Player_Entered_MiniBoss_Room
@warning_ignore("unused_signal")
signal Player_Entered_FinalBoss_Room
@warning_ignore("unused_signal")
signal Player_Entered_NextFloor_Room
#endregion

@warning_ignore("unused_signal")
signal Player_Entered_Shop_Room
@warning_ignore("unused_signal")
signal shop_exited
@warning_ignore("unused_signal")
signal Player_Entered_Rest_Room
@warning_ignore("unused_signal")
signal rest_site_exited
@warning_ignore("unused_signal")
signal Player_Entered_RandomEncounter_Room
@warning_ignore("unused_signal")
signal random_encounter_exited

@warning_ignore("unused_signal")
signal Fill_Legend_Buttons_Option(Current_Map_Stats: Map_Stats)

@warning_ignore("unused_signal")
signal combat_reward_exited

#needs to send;receive room type
signal go_to_room(room_target: Room3D)

signal Ask_Player_to_Select_Room_Type(room_target: Room3D)


@warning_ignore("unused_signal")
signal Player_Selected_a_Room_Type(my_room_type: Map_Stats.Room_Type)

@warning_ignore("unused_signal")
signal Update_Rooms_Reachability


var current_hovered_room3d: Array[Room3D]


func _input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton):
		return
	if not (event.button_index == MouseButton.MOUSE_BUTTON_LEFT):
		return
		
	if current_hovered_room3d.size() > 0 :
		
		var Temp_Room: Room3D = current_hovered_room3d[-1]
		
		if Temp_Room:
			
			
			if Temp_Room.is_reachable and Temp_Room.my_room_type != Map_Stats.Room_Type.UNDEFINED :
				
				go_to_room.emit(current_hovered_room3d[-1])
				
			else:
				Ask_Player_to_Select_Room_Type.emit(current_hovered_room3d[-1])
				
				
		#caso ele seja null
		else:
			current_hovered_room3d.remove_at(-1)
			print("Limpei um Null")



func Set_Currently_Hovered_Room_3d(room_3d_hovered: Room3D):
	current_hovered_room3d.push_back(room_3d_hovered)
	
func RESET_Hovered_Room3D(room_3d_unhovered: Room3D):
	current_hovered_room3d.erase(room_3d_unhovered)
