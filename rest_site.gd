class_name RestSite
extends Control

@export var character_stats: CharacterStats

@onready var rest_button: Button = $VBoxContainer/RestButton

func _on_button_pressed() -> void:
	GlobalMap.rest_site_exited.emit()


func _on_rest_button_pressed() -> void:
	character_stats.heal(character_stats.max_hp)
	rest_button.queue_free()
