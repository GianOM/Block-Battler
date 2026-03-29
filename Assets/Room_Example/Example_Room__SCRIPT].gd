class_name Room3D extends Node3D

signal Player_is_Hovering_Me(Room_Hovered: Room3D)

######
@export var combat_stats_pool: CombatStatsPool
@export var combat_stats: CombatStats

const STARTER_ROOM_COLOR: Color = Color(0.0, 0.0, 0.0, 1.0)
const NEXT_FLOOR_ROOM_COLOR: Color = Color(0.113, 0.555, 0.87, 1.0)

const NORMAL_ENEMY_BOSS_ROOM_COLOR: Color = Color(0.271, 0.212, 0.137, 1.0)
const MINI_BOSS_ROOM_COLOR: Color = Color(0.286, 0.133, 0.243)
const FINAL_BOSS_ROOM_COLOR: Color = Color(1.0, 0.47, 0.85, 1.0)


const SHOP_ROOM_COLOR: Color = Color(0.224, 0.353, 0.004, 1.0)
const REST_ROOM_COLOR: Color = Color(0.47, 0.168, 0.141, 1.0)
const RANDOM_ENCOUNTER_ROOM_COLOR: Color = Color(1.0, 0.883, 0.0, 1.0)


#region Room Stats
										#RIGHT, UP, LEFT, DOWN
										# se for 1, tem uma sala adjacente em uma das posicoes
var Adjacent_Rooms_Vector: Array[int] = [0,0,0,0]
var number_of_adjacents_rooms: int : set = set_number_of_adjacents_room

@onready var room_mesh_4_opens: MeshInstance3D = $Room_Mesh_4_Opens
@onready var room_mesh_3_opens: MeshInstance3D = $Room_Mesh_3_Opens
@onready var room_mesh_2_opens_a: MeshInstance3D = $Room_Mesh_2_Opens_A
@onready var room_mesh_2_opens_b: MeshInstance3D = $Room_Mesh_2_Opens_B
@onready var room_mesh_1_opens: MeshInstance3D = $Room_Mesh_1_Opens


#TODO: Setar o ID da sala
var Room_ID: int


#endregion


@onready var room_mesh: MeshInstance3D


var my_room_type: Map_Stats.Room_Type

func set_number_of_adjacents_room(quantity_of_adjacents_rooms: int):
	
	
	
	#$"Debug Text".text = str(Adjacent_Rooms_Vector)
	number_of_adjacents_rooms = quantity_of_adjacents_rooms
	
	match number_of_adjacents_rooms:
		1:
			room_mesh_1_opens.show()
			room_mesh = room_mesh_1_opens
			match Adjacent_Rooms_Vector:
				[1,0,0,0]:
					pass
				[0,1,0,0]:
					room_mesh_1_opens.rotation_degrees.y = 90
				[0,0,1,0]:
					room_mesh_1_opens.rotation_degrees.y = 180
				[0,0,0,1]:
					room_mesh_1_opens.rotation_degrees.y = 270
					
			
		2:
			match Adjacent_Rooms_Vector:
				[1,0,1,0]:
					room_mesh_2_opens_a.show()
					room_mesh = room_mesh_2_opens_a
				[0,1,0,1]:
					room_mesh_2_opens_a.show()
					room_mesh_2_opens_a.rotation_degrees.y = 90
					room_mesh = room_mesh_2_opens_a
					
					
				[0,0,1,1]:
					room_mesh_2_opens_b.show()
					room_mesh = room_mesh_2_opens_b
				[1,0,0,1]:
					room_mesh_2_opens_b.show()
					room_mesh_2_opens_b.rotation_degrees.y = 90
					room_mesh = room_mesh_2_opens_b
				[1,1,0,0]:
					room_mesh_2_opens_b.show()
					room_mesh_2_opens_b.rotation_degrees.y = 180
					room_mesh = room_mesh_2_opens_b
				[0,1,1,0]:
					room_mesh_2_opens_b.show()
					room_mesh_2_opens_b.rotation_degrees.y = 270
					room_mesh = room_mesh_2_opens_b
					
			
		3:
			room_mesh_3_opens.show()
			room_mesh = room_mesh_3_opens
			
			match Adjacent_Rooms_Vector:
				[1,0,1,1]:
					pass
				[1,1,0,1]:
					room_mesh_3_opens.rotation_degrees.y = 90
				[1,1,1,0]:
					room_mesh_3_opens.rotation_degrees.y = 180
				[0,1,1,1]:
					room_mesh_3_opens.rotation_degrees.y = 270
		4:
			room_mesh_4_opens.show()
			room_mesh = room_mesh_4_opens
	
	#$"Debug Text".text = str(number_of_adjacents_rooms)
	
	
	
	
	
	pass
	
	
	
func Set_Room_Gen_ID(room_gen_id: int):
	
	$"Debug Text".text = str(room_gen_id)
	
	
	
	
func Set_Room_Type(room_type: Map_Stats.Room_Type):
	my_room_type = room_type
	
	#  VERY IMPORTANT!!!!!11111
	combat_stats_pool.setup()
	
	match room_type:
		
		Map_Stats.Room_Type.STARTING:
			Set_Room_as_Starting_Room()
			
		Map_Stats.Room_Type.NEXTFLOOR:
			Set_Room_as_Next_Floor_Room()
			
		Map_Stats.Room_Type.NORMAL_ENEMY:
			combat_stats = combat_stats_pool.get_random_combat_for_tier(CombatStats.Tier.NORMAL)
			Set_Room_as_Enemy_Room()
		Map_Stats.Room_Type.MINI_BOSS:
			combat_stats = combat_stats_pool.get_random_combat_for_tier(CombatStats.Tier.ELITE)
			Set_Room_as_MiniBoss_Room()
			
		Map_Stats.Room_Type.FINAL_BOSS:
			Set_Room_as_FinalBoss_Room()
			
			
		Map_Stats.Room_Type.SHOP:
			Set_Room_as_Shop_Room()
		Map_Stats.Room_Type.REST:
			Set_Room_as_Rest_Room()
		Map_Stats.Room_Type.RANDOMENCOUNTER:
			Set_Room_as_Random_Encounter()
			
		_:
			pass
			#print("Null Found")
			
			
func On_Mouse_Hover():
	
	room_mesh.get_surface_override_material(0).set("emission_energy_multiplier", 2)
	
	
func On_Mouse_UnHover():
	
	room_mesh.get_surface_override_material(0).set("emission_energy_multiplier", 0)
	
	
func Set_Room_as_Starting_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", STARTER_ROOM_COLOR)
	room_mesh.get_surface_override_material(0).set("emission", Color(1.0, 1.0, 1.0, 1.0))
func Set_Room_as_Next_Floor_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", NEXT_FLOOR_ROOM_COLOR)
	room_mesh.get_surface_override_material(0).set("emission", NEXT_FLOOR_ROOM_COLOR)
	
	
	
func Set_Room_as_Enemy_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", NORMAL_ENEMY_BOSS_ROOM_COLOR)
	room_mesh.get_surface_override_material(0).set("emission", Color(1.0, 1.0, 1.0, 1.0))
func Set_Room_as_MiniBoss_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", MINI_BOSS_ROOM_COLOR)
	room_mesh.get_surface_override_material(0).set("emission", Color(1.0, 1.0, 1.0, 1.0))
func Set_Room_as_FinalBoss_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", FINAL_BOSS_ROOM_COLOR)
	room_mesh.get_surface_override_material(0).set("emission", Color(1.0, 1.0, 1.0, 1.0))
	
func Set_Room_as_Rest_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", REST_ROOM_COLOR)
	room_mesh.get_surface_override_material(0).set("emission", Color(1.0, 1.0, 1.0, 1.0))
func Set_Room_as_Shop_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", SHOP_ROOM_COLOR)
	room_mesh.get_surface_override_material(0).set("emission", Color(1.0, 1.0, 1.0, 1.0))
func Set_Room_as_Random_Encounter():
	room_mesh.get_surface_override_material(0).set("albedo_color", RANDOM_ENCOUNTER_ROOM_COLOR)
	room_mesh.get_surface_override_material(0).set("emission", Color(1.0, 1.0, 1.0, 1.0))
	

	
	
	
	
