class_name CombatReward
extends Control

const FBLOCK_REWARD = preload("res://UI/fblock_reward.tscn")
const REWARD_BUTTON = preload("res://reward_button.tscn")
const GOLD_ICON:= preload("res://Assets/gold_coin.png")
const FBLOCK_ICON:= preload("res://Assets/strength_power_icon.png")
const GOLD_TEXT:= "%s ゴールド"

@export var run_stats: RunStats
@export var character_stats: CharacterStats

@onready var rewards: VBoxContainer = %Rewards

func _ready() -> void:
	for i in rewards.get_children():
		i.queue_free()
	
	#debugging
	#run_stats = RunStats.new()
	#run_stats.gold_changed.connect(func(): print("gold: %s" % run_stats.gold))
	#add_gold_reward(77)
	#add_fblock_reward()


func add_gold_reward(amount: int):
	var gold_reward:= REWARD_BUTTON.instantiate()
	gold_reward.reward_icon = GOLD_ICON
	gold_reward.reward_text = GOLD_TEXT % amount
	gold_reward.pressed.connect(_on_gold_reward_taken.bind(amount))
	rewards.add_child(gold_reward)

func add_fblock_reward():
	var fblock_reward:= REWARD_BUTTON.instantiate()
	fblock_reward.reward_icon = FBLOCK_ICON
	fblock_reward.reward_text = "Add new function block"
	fblock_reward.pressed.connect(_show_fblock_reward)
	rewards.add_child(fblock_reward)
	
func _show_fblock_reward():
	if not run_stats or not character_stats:
		print("none")
		return
	print("actually")
	var fblock_rewards:= FBLOCK_REWARD.instantiate()
	add_child(fblock_rewards)
	fblock_rewards.fblock_reward_selected.connect(_on_fblock_reward_taken)
	
	var fblock_reward_array: Array[FBlock_Data]
	var available_fblocks: Array[FBlock_Data] = character_stats.obtainable_fblocks.fblocks_Data.duplicate(true)
	
	for i in 3: #3 being the amount of options on the screen
		var selected_fblock = available_fblocks.pick_random()
		fblock_reward_array.append(selected_fblock)
		available_fblocks.erase(selected_fblock)
	
	fblock_rewards.rewards = fblock_reward_array
	fblock_rewards.show()

func _on_fblock_reward_taken(fblock: FBlock_Data):
	if not character_stats or not fblock:
		return
	character_stats.run_pile.add_fblock(fblock)

func _on_gold_reward_taken(amount: int):
	if not run_stats:
		return
	run_stats.gold += amount

func _on_button_pressed() -> void:
	GlobalMap.combat_reward_exited.emit()
