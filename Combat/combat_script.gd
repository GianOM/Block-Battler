extends Node2D

@onready var entity: Entity = $EntityUI


func _on_shield_5_pressed() -> void:
	if entity:
		entity.give_shield(5)


func _on_shield_10_pressed() -> void:
	if entity:
		entity.give_shield(10)


func _on_dmg_5_pressed() -> void:
	if entity:
		entity.take_damage(5)


func _on_dmg_10_pressed() -> void:
	if entity:
		entity.take_damage(10)
