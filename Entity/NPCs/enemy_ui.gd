class_name Enemy
extends Node2D

@export var stats: EntityStats: set = set_entity_stats

@onready var entity_image: Sprite2D = $EntityImage
@onready var stats_ui: StatsUI = $StatsUI as StatsUI

func set_entity_stats(value: EntityStats):
	stats = value.create_instance()
	if not stats.changes_in_stats.is_connected(update_stats):
		stats.changes_in_stats.connect(update_stats)
	update_enemy()

func update_stats():
	stats_ui.update_stats(stats)
	
func update_enemy():
	if not stats is EntityStats:
		return
	if not is_inside_tree():
		await ready
	entity_image.texture = stats.image
	update_stats()

func take_damage(damage: int):
	if stats.hp <= 0:
		return
	stats.take_damage(damage)
	if stats.hp <= 0:
		print("enemy deadge")
		queue_free()

func give_shield(value: int):
	stats.shield += clampi(value, 0, 999)
	update_stats()
