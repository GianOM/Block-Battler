extends CanvasLayer

@onready var floor_label: Label = $"Floor Label"

var Floor_Number: int = 1


func _ready() -> void:
	
	GlobalMap.Player_Entered_NextFloor_Room.connect(_on_Next_Floor_Solicited)
	floor_label.text = "Floor " + str(Floor_Number)
	
	
	UI_Globals.Show_Map_UI.connect(Show_Map_UI)
	UI_Globals.Hide_Map_UI.connect(Hide_Map_UI)
	
	
func _on_Next_Floor_Solicited():
	
	Floor_Number += 1
	floor_label.text = "Floor " + str(Floor_Number)
	
	
func Show_Map_UI():
	
	visible = true
	
func Hide_Map_UI():
	
	visible = false
	
	
