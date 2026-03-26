extends Node3D


const FINAL_BOSS_ROOM_COLOR: Color = Color(1.0, 0.47, 0.85, 1.0)
const MINI_BOSS_ROOM_COLOR: Color = Color(0.286, 0.133, 0.243)
const NORMAL_ENEMY_BOSS_ROOM_COLOR: Color = Color(0.271, 0.212, 0.137, 1.0)

const SHOP_ROOM_COLOR: Color = Color(0.224, 0.353, 0.004, 1.0)
const REST_ROOM_COLOR: Color = Color(0.47, 0.168, 0.141, 1.0)
const RANDOM_ENCOUNTER_ROOM_COLOR: Color = Color(1.0, 0.883, 0.0, 1.0)

const STARTER_ROOM_COLOR: Color = Color(0.0, 0.0, 0.0, 1.0)



@onready var room_mesh: MeshInstance3D = $Room_Mesh
	
	
	
func Set_Room_Type(my_room_type: Map_Stats.Room_Type):
	match my_room_type:
		
		Map_Stats.Room_Type.STARTING:
			Set_Room_as_Starting_Room()
			
		Map_Stats.Room_Type.NORMAL_ENEMY:
			Set_Room_as_Enemy_Room()
		Map_Stats.Room_Type.MINI_BOSS:
			Set_Room_as_MiniBoss_Room()
		Map_Stats.Room_Type.FINAL_BOSS:
			Set_Room_as_FinalBoss_Room()
			
		Map_Stats.Room_Type.SHOP:
			Set_Room_as_Rest_Room()
		Map_Stats.Room_Type.REST:
			Set_Room_as_Shop_Room()
		Map_Stats.Room_Type.RANDOMENCOUNTER:
			Set_Room_as_Random_Encounter()
			
		_:
			print("Null Found")
	
	
	
	
func Set_Room_as_Starting_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", STARTER_ROOM_COLOR)
	
	
func Set_Room_as_Enemy_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", NORMAL_ENEMY_BOSS_ROOM_COLOR)
func Set_Room_as_MiniBoss_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", MINI_BOSS_ROOM_COLOR)
func Set_Room_as_FinalBoss_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", FINAL_BOSS_ROOM_COLOR)
	
	
func Set_Room_as_Rest_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", REST_ROOM_COLOR)
func Set_Room_as_Shop_Room():
	room_mesh.get_surface_override_material(0).set("albedo_color", SHOP_ROOM_COLOR)
func Set_Room_as_Random_Encounter():
	room_mesh.get_surface_override_material(0).set("albedo_color", RANDOM_ENCOUNTER_ROOM_COLOR)
	

	
	
	
	
