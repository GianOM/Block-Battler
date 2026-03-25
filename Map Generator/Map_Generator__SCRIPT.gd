extends Node3D

const EXAMPLE_ROOM__SCENE = preload("uid://ch2t4yt6uxcwt")

@onready var rooms_root: Node3D = $Rooms_Root

var List_of_Positions_Walked: Array[Vector2i]


@export var number_of_room: int = 45
@export var starter_position: Vector2i = Vector2i.ZERO


var RNG = RandomNumberGenerator.new()


@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Clear_All_Room()
		Drunkard_Walk()
		



func _ready() -> void:
	
	Drunkard_Walk()
	
	
	
func Clear_All_Room():
	
	List_of_Positions_Walked.clear()
	starter_position = Vector2i.ZERO
	for individual_room in rooms_root.get_children():
		individual_room.queue_free()
	
func Drunkard_Walk():
	
	var Remaining_Number_of_Placed_Rooms: int = number_of_room
	var current_drunk_position : Vector2i = starter_position
	
	
	
	while Remaining_Number_of_Placed_Rooms > 0:
		
		if not List_of_Positions_Walked.has(current_drunk_position):
			
			List_of_Positions_Walked.push_back(current_drunk_position)
			Instance_Room_on_drunk_position(current_drunk_position)
			Remaining_Number_of_Placed_Rooms -= 1
			
		current_drunk_position = Take_Drunken_Step(current_drunk_position)
			
		
	
	
func Instance_Room_on_drunk_position(input_drunk_position: Vector2i):
	
	
	
	var Global_XYZ_Room_Coordinates: Vector3 = (Vector3(input_drunk_position.x,0,input_drunk_position.y)) * 4
	
	var Temp_Scene: Node = EXAMPLE_ROOM__SCENE.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	
	rooms_root.add_child(Temp_Scene)
	
	Temp_Scene.global_position = Global_XYZ_Room_Coordinates
	
		
		
		
		
		
		
func Take_Drunken_Step(input_position: Vector2i) -> Vector2i:
	
	var drunk_position_after_step: Vector2i
	
	var next_step_number: int = RNG.randi_range(0, 3)
	
	
	match next_step_number:
		0:#FORWARD STEP
			drunk_position_after_step = input_position + Vector2i(1,0)
		1:#BACKWARD STEP
			drunk_position_after_step = input_position - Vector2i(1,0)
			
			
		2:#LEFT STEP
			drunk_position_after_step = input_position + Vector2i(0,1)
		3:#RIGHT STEP
			drunk_position_after_step = input_position - Vector2i(0,1)
			
	if (drunk_position_after_step.distance_to(starter_position)) > 15.0:
		
		var next_starter_positon_idx: int = RNG.randi_range(0, List_of_Positions_Walked.size() - 1)
		
		starter_position = List_of_Positions_Walked[next_starter_positon_idx]
		
		drunk_position_after_step = starter_position
		print("VOLTE SUA MISEERA")
	
	return drunk_position_after_step
	
	
	
	
	
	
		
