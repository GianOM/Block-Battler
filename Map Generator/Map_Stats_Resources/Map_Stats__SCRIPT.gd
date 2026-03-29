class_name Map_Stats extends Resource

enum Room_Type{
	STARTING,
	NEXTFLOOR,
	NORMAL_ENEMY,
	MINI_BOSS,
	FINAL_BOSS,
	SHOP,
	REST,
	RANDOMENCOUNTER
}

var MY_SEED: RandomNumberGenerator = RandomNumberGenerator.new()

@export var Number_of_Starting_Points: int = 1
@export var Number_of_Next_Floor_Rooms: int = 1

@export var Number_of_Normal_Enemiess: int = 10
@export var Number_of_Mini_Boss: int = 5
@export var Number_of_Final_Boss: int = 1

@export var Number_of_Shops: int = 3
@export var Number_of_Rests: int = 3

@export var Number_of_Random_Encounters: int = 5


var Total_Number_of_Rooms: int = 0



func _init() -> void:
	Calculate_Total_Number_of_Rooms()
	
	
func Calculate_Total_Number_of_Rooms():
	
	Total_Number_of_Rooms += (Number_of_Starting_Points + Number_of_Next_Floor_Rooms +
								Number_of_Normal_Enemiess + Number_of_Mini_Boss + Number_of_Final_Boss +
								Number_of_Shops + Number_of_Rests + 
								Number_of_Random_Encounters)
	




func Get_Random_Room() -> Room_Type:
	
	
	#WARNING: PRECISA ESTAR NA MESMA ORDEM QUE O ENUM ROOM_TYPE
	var List_of_Possibilities: Array[Room_Type]
	
	
	if Number_of_Starting_Points > 0:
		List_of_Possibilities.append(Room_Type.STARTING)
	if Number_of_Next_Floor_Rooms > 0:
		List_of_Possibilities.append(Room_Type.NEXTFLOOR)
		
	if Number_of_Normal_Enemiess > 0:
		List_of_Possibilities.append(Room_Type.NORMAL_ENEMY)
		
	if Number_of_Mini_Boss > 0:
		List_of_Possibilities.append(Room_Type.MINI_BOSS)
		
	if Number_of_Final_Boss > 0:
		List_of_Possibilities.append(Room_Type.FINAL_BOSS)
		
	if Number_of_Shops > 0:
		List_of_Possibilities.append(Room_Type.SHOP)
		
	if Number_of_Rests > 0:
		List_of_Possibilities.append(Room_Type.REST)
	
	if Number_of_Random_Encounters > 0:
		List_of_Possibilities.append(Room_Type.RANDOMENCOUNTER)
		
		
		
		
	if List_of_Possibilities.size() > 0:
		
		
		var choosen_int: int = randi_range(0,List_of_Possibilities.size() - 1)
		#print(Room_Type.keys()[choosen_int])
		
		Subtract_Number_of_Possible_Rooms(List_of_Possibilities[choosen_int])
	
	
		return List_of_Possibilities[choosen_int]
		
	return 999
	
	
	
func Subtract_Number_of_Possible_Rooms(room_type_to_subtract: Room_Type):
	
	
	match room_type_to_subtract:
		Room_Type.STARTING:
			Number_of_Starting_Points -= 1
		Room_Type.NEXTFLOOR:
			Number_of_Next_Floor_Rooms -= 1
			
		Room_Type.NORMAL_ENEMY:
			Number_of_Normal_Enemiess -= 1
		Room_Type.MINI_BOSS:
			Number_of_Mini_Boss -= 1
		Room_Type.FINAL_BOSS:
			Number_of_Final_Boss -= 1
			
		Room_Type.SHOP:
			Number_of_Shops -= 1
		Room_Type.REST:
			Number_of_Rests -= 1
			
		Room_Type.RANDOMENCOUNTER:
			Number_of_Random_Encounters -= 1
			
		_:
			#print("")
			pass
		
	
	
	
