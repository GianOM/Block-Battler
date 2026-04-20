class_name Run
extends Node

const COMBAT_SCENE:= preload("res://Combat/combat_2d.tscn")
const COMBAT_REWARD_SCENE:= preload("res://combat_reward.tscn")
const REST_SITE_SCENE:= preload("res://rest_site.tscn")
const SHOP_SCENE:= preload("res://shop.tscn")
const RANDOM_ENCOUNTER_SCENE:= preload("res://random_encounter.tscn")

#ui stuff
@onready var gold_ui: GoldUI = %GoldUI
@onready var hp_ui: HPUI = %HPUI

@onready var current_scene: Node = $CurrentScene
@onready var map: Node3D = $MapGeneratorScene


var run_stats: RunStats
var player_character: CharacterStats

var last_combat_room: Room3D

func _ready() -> void:
	#temporary
	if not player_character:
		var test_character:= load("res://Entity/Player/test_character/character_test.tres")
		player_character = test_character.create_instance()
	
	_start_run()

func _start_run():
	#temp
	run_stats = RunStats.new()
	
	_setup_connections()
	_setup_ui()
	
	
	
func Enable_Map():
	map.process_mode = Node.PROCESS_MODE_ALWAYS
	map.show()
	
	UI_Globals.Show_Map_UI.emit()
	
	
func Disable_Map():
	map.hide()
	map.process_mode = Node.PROCESS_MODE_DISABLED
	
	UI_Globals.Hide_Map_UI.emit()
	
	
#go to map when you proceed from a room
func _go_to_map():
	if current_scene.get_child_count() > 0:
		current_scene.get_child(0).queue_free()
		
	Enable_Map()
	
	
	
	
	
#needs to receive the room type
func _next_room_from_map(room: Room3D):
	#from the room type received, match it to 
	#_change_current_scene(scene which matches the received room type)
	
	# Se ja visitamos a sala, nao repetir o encounter
	if room.was_visited:
		return
		
	room.was_visited = true
	
	GlobalMap.Update_Rooms_Reachability.emit()
	
	match room.my_room_type:
		Map_Stats.Room_Type.NORMAL_ENEMY:
			_combat_room_entered(room)
			Disable_Map()
			
		Map_Stats.Room_Type.REST:
			_rest_site_entered()
			Disable_Map()
			
		Map_Stats.Room_Type.SHOP:
			_change_current_scene(SHOP_SCENE)
			Disable_Map()
			
		Map_Stats.Room_Type.RANDOMENCOUNTER:
			_change_current_scene(RANDOM_ENCOUNTER_SCENE)
			Disable_Map()
			
		Map_Stats.Room_Type.MINI_BOSS:
			_combat_room_entered(room)
			Disable_Map()
		Map_Stats.Room_Type.FINAL_BOSS:
			pass
			
		Map_Stats.Room_Type.NEXTFLOOR:
			GlobalMap.Player_Entered_NextFloor_Room.emit()
			
	await get_tree().create_timer(0.5).timeout
	
func _combat_room_entered(room: Room3D):
	var combat_scene: Combat = _change_current_scene(COMBAT_SCENE)
	combat_scene.character_stats = player_character
	#combat_scene.combat_stats = preload("res://combat_presets/normal_1_head.tres")
	combat_scene.combat_stats = room.combat_stats
	last_combat_room = room
	combat_scene.start_combat()

func _rest_site_entered():
	var rest_site:= _change_current_scene(REST_SITE_SCENE) as RestSite
	rest_site.character_stats = player_character
	

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

func _setup_ui():
	player_character.changes_in_stats.connect(hp_ui.update_stats.bind(player_character))
	hp_ui.update_stats(player_character)
	gold_ui.run_stats = run_stats

func _setup_connections():
	COMBATE.combat_won.connect(_on_combat_won)
	
	GlobalMap.combat_reward_exited.connect(_go_to_map)
	GlobalMap.rest_site_exited.connect(_go_to_map)
	GlobalMap.shop_exited.connect(_go_to_map)
	GlobalMap.random_encounter_exited.connect(_go_to_map)
	GlobalMap.go_to_room.connect(_next_room_from_map)

func _on_combat_won():
	var reward_scene:= _change_current_scene(COMBAT_REWARD_SCENE) as CombatReward
	reward_scene.run_stats = run_stats
	reward_scene.character_stats = player_character
	
	reward_scene.add_gold_reward(last_combat_room.combat_stats.roll_gold_reward())
	reward_scene.add_fblock_reward()
