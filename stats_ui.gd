class_name StatsUI
extends HBoxContainer

@onready var shield: HBoxContainer = $Shield
@onready var shield_label: Label = %ShieldLabel
@onready var hp: HBoxContainer = $HP
@onready var hp_label: Label = %HPLabel

func update_stats(stats:EntityStats):
	shield_label.text = str(stats.shield)
	hp_label.text = str(stats.hp)
	
	shield.visible = stats.shield > 0
	hp.visible = stats.hp > 0
