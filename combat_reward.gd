class_name CombatReward
extends Control

const REWARD_BUTTON = preload("res://reward_button.tscn")
const GOLD_ICON:= preload("res://Assets/gold_coin.png")
const GOLD_TEXT:= "%s ゴールド"

@export var run_stats: RunStats
@export var character_stats: CharacterStats

@onready var rewards: VBoxContainer = %Rewards

func _ready() -> void:
	for i in rewards.get_children():
		i.queue_free()
	
	#run_stats = RunStats.new()
	#run_stats.gold_changed.connect(func(): print("gold: %s" % run_stats.gold))
	#add_gold_reward(77)


func add_gold_reward(amount: int):
	var gold_reward:= REWARD_BUTTON.instantiate()
	gold_reward.reward_icon = GOLD_ICON
	gold_reward.reward_text = GOLD_TEXT % amount
	gold_reward.pressed.connect(_on_gold_reward_taken.bind(amount))
	rewards.add_child(gold_reward)

func _on_gold_reward_taken(amount: int):
	if not run_stats:
		return
	run_stats.gold += amount

func _on_button_pressed() -> void:
	GlobalMap.combat_reward_exited.emit()
