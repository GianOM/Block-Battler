extends Control


func _on_button_pressed() -> void:
	GlobalMap.random_encounter_exited.emit()
