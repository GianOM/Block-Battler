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


func _ready() -> void:
	GlobalMap.Fill_Legend_Buttons_Option.connect(Fill_Room_Options)
	
	
	
func Fill_Room_Options(my_map_stats: Map_Stats):
	
	starting_room_label.text = "Starting Room\n" + str(my_map_stats.Number_of_Starting_Points)
	
	next_floor_room.text = "Next Floor\n" + str(my_map_stats.Number_of_Next_Floor_Rooms)
	
	normal_enemy.text = "Normal Enemy\n" + str(my_map_stats.Number_of_Normal_Enemiess)
	
	mini_boss.text = "Mini Boss\n" + str(my_map_stats.Number_of_Mini_Boss)
	
	final_boss.text = "Final Boss\n" + str(my_map_stats.Number_of_Final_Boss)
	
	shop_room.text = "Shop Room\n" + str(my_map_stats.Number_of_Shops)
	
	rest_room.text = "Rest Room\n" + str(my_map_stats.Number_of_Rests)
	
	random_encounter.text = "Random Encounter\n" + str(my_map_stats.Number_of_Random_Encounters)
	
	nothing.text = "Not Available\n" + str(my_map_stats.Calculate_Total_Number_of_Rooms())
	



func _on_return_button_pressed() -> void:
	GlobalMap.close_map.emit()
