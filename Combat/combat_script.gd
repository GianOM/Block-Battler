extends Node2D

@onready var entity: Enemy = $EntityUI

var effect

func _on_shield_5_pressed() -> void:
	if entity:
		effect = Shield.new()
		effect.amount = 5
		effect.execute(entity)


func _on_shield_10_pressed() -> void:
	if entity:
		effect = Shield.new()
		effect.amount = 10
		effect.execute(entity)


func _on_dmg_5_pressed() -> void:
	if entity:
		effect = Damage.new()
		effect.amount = 5
		effect.execute(entity)


func _on_dmg_10_pressed() -> void:
	if entity:
		effect = Damage.new()
		effect.amount = 10
		effect.execute(entity)
