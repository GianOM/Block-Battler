class_name HPUI
extends HBoxContainer

@export var show_max_hp: bool

@onready var hp_label: Label = %HPLabel
@onready var max_hp_label: Label = %MaxHPLabel

func update_stats(stats: EntityStats):
	hp_label.text = str(stats.hp)
	max_hp_label.text = "/%s" % str(stats.max_hp)
	max_hp_label.visible = show_max_hp
