extends Node3D

signal Finished_Cleaning_Children


var Rooms_Positions: Array[Vector2i]


func Fill_Rooms_Info():
	
	var List_of_Room: Array[Node] = get_children()
	
	
	for individual_Room in List_of_Room:
		
		#var My_Coordinates: String = individual_Room.name
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
	
	
	
	
	
	for room in get_children():
		
		#remove_child(room)
		room.free()
		
	await get_tree().process_frame
	
	
	Finished_Cleaning_Children.emit()
	
	
	
