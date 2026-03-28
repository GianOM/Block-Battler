class_name Run
extends Node

const COMBAT_SCENE:= preload("res://Combat/combat_2d.tscn")
const COMBAT_REWARD_SCENE:= preload("res://combat_reward.tscn")
const REST_SITE_SCENE:= preload("res://rest_site.tscn")
const SHOP_SCENE:= preload("res://shop.tscn")
const RANDOM_ENCOUNTER_SCENE:= preload("res://random_encounter.tscn")

@onready var current_scene: Node = $CurrentScene
@onready var map: Node3D = $MapGeneratorScene


var player_character: CharacterStats

func _ready() -> void:
	#temporary
	if not player_character:
		var test_character:= load("res://Entity/Player/character_test.tres")
		player_character = test_character.create_instance()
	
	_start_run()

func _start_run():
	COMBATE.combat_won.connect(_change_current_scene.bind(COMBAT_REWARD_SCENE))
	GlobalMap.combat_reward_exited.connect(_go_to_map)
	GlobalMap.rest_site_exited.connect(_go_to_map)
	GlobalMap.shop_exited.connect(_go_to_map)
	GlobalMap.random_encounter_exited.connect(_go_to_map)
	GlobalMap.go_to_room.connect(_next_room_from_map)

#go to map when you proceed from a room
func _go_to_map():
	if current_scene.get_child_count() > 0:
		current_scene.get_child(0).queue_free()
	
	map.process_mode = Node.PROCESS_MODE_ALWAYS
	map.show()
	
	
#needs to receive the room type
func _next_room_from_map(room: Room3D):
	#from the room type received, match it to 
	#_change_current_scene(scene which matches the received room type)
	match room.my_room_type:
		Map_Stats.Room_Type.NORMAL_ENEMY:
			_change_current_scene(COMBAT_SCENE)
		Map_Stats.Room_Type.REST:
			_change_current_scene(REST_SITE_SCENE)
		Map_Stats.Room_Type.SHOP:
			_change_current_scene(SHOP_SCENE)
		Map_Stats.Room_Type.RANDOMENCOUNTER:
			_change_current_scene(RANDOM_ENCOUNTER_SCENE)
		Map_Stats.Room_Type.MINI_BOSS:
			pass
		Map_Stats.Room_Type.FINAL_BOSS:
			pass
	map.process_mode = Node.PROCESS_MODE_DISABLED

func _change_current_scene(scene: PackedScene):
	#combat and event scenes are instantiated under CurrentScreen
	#when the combat is over, delete the currently instantiated scene
	#to instantiate the next one
	if current_scene.get_child_count() > 0:
		current_scene.get_child(0).queue_free()
	
	#battle over scene pauses the game, this unpauses it
	get_tree().paused = false
	
	var new_scene:= scene.instantiate()
	current_scene.add_child(new_scene)
	map.hide()
	
	return new_scene
