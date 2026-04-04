extends Node3D

signal Finished_Cleaning_Children


@export var selected_Map_Stats: Map_Stats
var Current_MapStats: Map_Stats


@export var Player_Icon:MeshInstance3D


var Rooms_Positions: Array[Vector2i]

func _enter_tree() -> void:
	Current_MapStats = selected_Map_Stats.duplicate()
	

func _ready() -> void:
	GlobalMap.Update_Rooms_Reachability.connect(_on_Player_Arrived_at_New_Room3D)


func _on_Player_Arrived_at_New_Room3D():
	# Linha 27 setada agora pelo Run.gd, pois ele precisa saber antes de todo mundo
	# se a room ja foi visitada para gerar o encontro
	
	#new_player_room.was_visited = true
	
	Update_Rooms_Reachability()
	Write_All_Rooms_Debug()
	
	
func Fill_Rooms_Info():
	
	var List_of_Room: Array[Node] = get_children()
	
	
	for individual_Room in List_of_Room:
		
		#var My_Coordinates: String = individual_Room.name
		
		var room_idx: int = individual_Room.get_index()
		individual_Room.Set_Room_Gen_ID(room_idx)
		
		Total_Number_of_Adjacents_Rooms(individual_Room, List_of_Room)
		
		var current_room_type: Map_Stats.Room_Type = Current_MapStats.Get_Random_Room()
		
		
		if current_room_type == Map_Stats.Room_Type.STARTING:
			Player_Icon.move_player_icon_to_room(individual_Room)
		
		individual_Room.Set_Room_Type(current_room_type)
		
		
	Update_Rooms_Reachability()
	Write_All_Rooms_Debug()
		
		
		
func Update_Rooms_Reachability():
	
	for individual_Room in get_children():
		if individual_Room.was_visited:
			for i in range(individual_Room.Adjacent_Rooms_Reference.size()):
				individual_Room.Adjacent_Rooms_Reference[i].is_reachable = true
				
				




func Write_All_Rooms_Debug():
	for individual_Room in get_children():
		individual_Room.Write_Debug()
		
	
func Total_Number_of_Adjacents_Rooms(room_ref: Node3D, rooms_list: Array[Node]):
	
	#										RIGHT, UP, LEFT, DOWN
	var Temp_Has_Adjacent_Room: Array[int] = [0,0,0,0]
	var Total_of_Adjacents_Rooms: int = 0
	
	var coordinates_to_search: Vector3 = room_ref.global_position
	
	# +GLOBAL X AXIS = RIGHT
	# -GLOBAL Z AXIS = UP
	# -GLOBAL X AXIS = LEFT
	# +GLOBAL Z AXIS = DOWN
	
	
	for my_room in rooms_list:
		
		
		#RIGHT
		if my_room.global_position == (coordinates_to_search + Vector3(4,0,0)):
			Total_of_Adjacents_Rooms += 1
			Temp_Has_Adjacent_Room[0] = 1
			
			
			room_ref.Adjacent_Rooms_Reference.append(my_room)
			
		#UP
		elif my_room.global_position == (coordinates_to_search + Vector3(0,0,-4)):
			Total_of_Adjacents_Rooms += 1
			Temp_Has_Adjacent_Room[1] = 1
			
			room_ref.Adjacent_Rooms_Reference.append(my_room)
			
		#LEFT
		elif my_room.global_position == (coordinates_to_search + Vector3(-4,0,0)):
			Total_of_Adjacents_Rooms += 1
			Temp_Has_Adjacent_Room[2] = 1
			
			room_ref.Adjacent_Rooms_Reference.append(my_room)
		
			
		#DOWN
		elif my_room.global_position == (coordinates_to_search + Vector3(0,0,4)):
			Total_of_Adjacents_Rooms += 1
			Temp_Has_Adjacent_Room[3] = 1
			
			room_ref.Adjacent_Rooms_Reference.append(my_room)
			
		
			
		
			
		
		
			
	room_ref.Has_Adjacent_Room = Temp_Has_Adjacent_Room
	room_ref.number_of_adjacents_rooms = Total_of_Adjacents_Rooms
	
	
	
	
	
func Clear_All_Children():
	
	Current_MapStats = selected_Map_Stats.duplicate()
	
	for room in get_children():
		room.free()
		
	await get_tree().process_frame
	
		
	Finished_Cleaning_Children.emit()
	
	
	
