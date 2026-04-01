class_name StatsUI
extends HBoxContainer

@onready var shield: HBoxContainer = $Shield
@onready var shield_label: Label = %ShieldLabel
@onready var hp: HPUI = $HP

func update_stats(stats:EntityStats):
	shield_label.text = str(stats.shield)
	hp.update_stats(stats)
	
	shield.visible = stats.shield > 0
	hp.visible = stats.hp > 0
