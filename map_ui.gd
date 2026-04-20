extends Control

@onready var starting_room_label: Button = $"VBoxContainer/Starting Room Label"
@onready var next_floor_room: Button = $"VBoxContainer/Next Floor Room"
@onready var normal_enemy: Button = $"VBoxContainer/Normal Enemy"
@onready var mini_boss: Button = $"VBoxContainer/Mini Boss"
@onready var final_boss: Button = $"VBoxContainer/Final Boss"
@onready var shop_room: Button = $"VBoxContainer/Shop Room"
@onready var rest_room: Button = $"VBoxContainer/Rest Room"
@onready var random_encounter: Button = $"VBoxContainer/Random Encounter"
@onready var nothing: Button = $VBoxContainer/Nothing
@onready var return_button: Button = $VBoxContainer/ReturnButton

@onready var intermezzo_screen: Panel = $"Intermezzo Screen"



var Temp_Room: Room3D

func _ready() -> void:
	
	Connect_Rooms_Buttons()
	
	
	GlobalMap.Fill_Legend_Buttons_Option.connect(Fill_Room_Options)
	GlobalMap.Ask_Player_to_Select_Room_Type.connect(Reveal_Intermezzo)
	
	
	
	
func Fill_Room_Options(my_map_stats: Map_Stats):
	
	starting_room_label.text = "Starting Room\n" + str(my_map_stats.Number_of_Starting_Points)
	if my_map_stats.Number_of_Starting_Points == 0:
		starting_room_label.disabled = true
	
	next_floor_room.text = "Next Floor\n" + str(my_map_stats.Number_of_Next_Floor_Rooms)
	
	normal_enemy.text = "Normal Enemy\n" + str(my_map_stats.Number_of_Normal_Enemiess)
	
	mini_boss.text = "Mini Boss\n" + str(my_map_stats.Number_of_Mini_Boss)
	
	final_boss.text = "Final Boss\n" + str(my_map_stats.Number_of_Final_Boss)
	if my_map_stats.Number_of_Final_Boss == 0:
		final_boss.disabled = true
	
	shop_room.text = "Shop Room\n" + str(my_map_stats.Number_of_Shops)
	
	rest_room.text = "Rest Room\n" + str(my_map_stats.Number_of_Rests)
	
	random_encounter.text = "Random Encounter\n" + str(my_map_stats.Number_of_Random_Encounters)
	
	nothing.text = "Not Available\n" + str(my_map_stats.Calculate_Total_Number_of_Rooms())
	
	
	
func Connect_Rooms_Buttons():
	
	starting_room_label.pressed.connect(_on_Room_Button_Pressed.bind(Map_Stats.Room_Type.STARTING))
	
	next_floor_room.pressed.connect(_on_Room_Button_Pressed.bind(Map_Stats.Room_Type.NEXTFLOOR))
	
	normal_enemy.pressed.connect(_on_Room_Button_Pressed.bind(Map_Stats.Room_Type.NORMAL_ENEMY))
	
	mini_boss.pressed.connect(_on_Room_Button_Pressed.bind(Map_Stats.Room_Type.MINI_BOSS))
	
	final_boss.pressed.connect(_on_Room_Button_Pressed.bind(Map_Stats.Room_Type.FINAL_BOSS))
	
	shop_room.pressed.connect(_on_Room_Button_Pressed.bind(Map_Stats.Room_Type.SHOP))
	
	rest_room.pressed.connect(_on_Room_Button_Pressed.bind(Map_Stats.Room_Type.REST))
	
	random_encounter.pressed.connect(_on_Room_Button_Pressed.bind(Map_Stats.Room_Type.RANDOMENCOUNTER))
	
	
	pass
	
	
	
func _on_Room_Button_Pressed(room_type: Map_Stats.Room_Type):
	
	
	if not intermezzo_screen.is_visible_in_tree():
		return
		
	intermezzo_screen.hide()
	Temp_Room.Set_Room_Type(room_type)
	
	
	
	#GlobalMap.Player_Selected_a_Room_Type.emit(room_type)
	
	
	
	
	
	
func Reveal_Intermezzo(room_to_set_type: Room3D):
	
	intermezzo_screen.show()
	Temp_Room = room_to_set_type
	
	



func _on_return_button_pressed() -> void:
	GlobalMap.close_map.emit()
