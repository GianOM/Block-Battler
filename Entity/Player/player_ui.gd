class_name Player
extends Node2D

@export var stats: CharacterStats: set = set_character_stats

@onready var player_image: Sprite2D = $PlayerImage
@onready var stats_ui: StatsUI = $StatsUI

func set_character_stats(value: CharacterStats):
	stats = value
	if not stats.changes_in_stats.is_connected(update_stats):
		stats.changes_in_stats.connect(update_stats)
	update_player()

func update_player():
	if not stats is CharacterStats:
		return
	if not is_inside_tree():
		await ready
	player_image.texture = stats.image
	update_stats()

func update_stats():
	stats_ui.update_stats(stats)

func take_damage(damage: int):
	if stats.hp <= 0:
		return
	var tween:= create_tween()
	tween.tween_callback(COMBATE.shake.bind(self, 16, 0.15))
	tween.tween_callback(stats.take_damage.bind(damage))
	tween.tween_interval(0.2)
	tween.finished.connect(
		func():
			if stats.hp <= 0:
				COMBATE.player_died.emit()
				queue_free()
	)
