extends Node3D

signal Finished_Cleaning_Children


@export var selected_Map_Stats: Map_Stats
var Current_MapStats: Map_Stats


@export var Player_Icon:MeshInstance3D


var Rooms_Positions: Array[Vector2i]

func _enter_tree() -> void:
	Current_MapStats = selected_Map_Stats.duplicate()
	


func Fill_Rooms_Info():
	
	var List_of_Room: Array[Node] = get_children()
	
	
	for individual_Room in List_of_Room:
		
		#var My_Coordinates: String = individual_Room.name
		
		var room_idx: int = individual_Room.get_index()
		individual_Room.Set_Room_Gen_ID(room_idx)
		
		var current_room_type: Map_Stats.Room_Type = Current_MapStats.Get_Random_Room()
		
		
		if current_room_type == Map_Stats.Room_Type.STARTING:
			Player_Icon.move_player_icon_to_room(individual_Room)
		
		individual_Room.Set_Room_Type(current_room_type)
		
		individual_Room.number_of_adjacents_rooms = Total_Number_of_Adjacents_Rooms(individual_Room, List_of_Room)
	
func Total_Number_of_Adjacents_Rooms(room_ref: Node3D, rooms_list: Array[Node]) -> int:
	
	var Total_of_Adjacents_Rooms: int = 0
	
	var coordinates_to_search: Vector3 = room_ref.global_position
	
	
	for my_room in rooms_list:
		
		if my_room.global_position == (coordinates_to_search + Vector3(4,0,0)):
			Total_of_Adjacents_Rooms += 1
			
		if my_room.global_position == (coordinates_to_search + Vector3(-4,0,0)):
			Total_of_Adjacents_Rooms += 1
			
		if my_room.global_position == (coordinates_to_search + Vector3(0,0,4)):
			Total_of_Adjacents_Rooms += 1
			
		if my_room.global_position == (coordinates_to_search + Vector3(0,0,-4)):
			Total_of_Adjacents_Rooms += 1
	
	
	return Total_of_Adjacents_Rooms
	
	
	
	
	
func Clear_All_Children():
	
	
	Current_MapStats = selected_Map_Stats.duplicate()
	
	
	for room in get_children():
		
		#remove_child(room)
		room.free()
		
	await get_tree().process_frame
	
		
	Finished_Cleaning_Children.emit()
	
	
	
