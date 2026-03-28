extends Control


func _on_button_pressed() -> void:
	GlobalMap.combat_reward_exited.emit()
