extends CanvasLayer

@onready var floor_label: Label = $"Floor Label"

var Floor_Number: int = 1


func _ready() -> void:
	
	GlobalMap.Player_Entered_NextFloor_Room.connect(_on_Next_Floor_Solicited)
	floor_label.text = "Floor " + str(Floor_Number)
	
	
func _on_Next_Floor_Solicited():
	
	Floor_Number += 1
	floor_label.text = "Floor " + str(Floor_Number)
	
	
