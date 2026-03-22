class_name Run
extends Node

const COMBAT_SCENE:= preload("res://UI/Main_UI/Combat_Scenes/Combat_UI.tscn")

@onready var current_scene: Node = $CurrentScene

var player_character: CharacterStats

func _ready() -> void:
	#temporary
	if not player_character:
		var test_character:= load("res://Entity/Player/character_test.tres")
		player_character = test_character.create_instance()
	
	_start_run()

func _start_run():
	#TODO setup event connections and generate map
	pass

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
	
