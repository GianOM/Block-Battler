extends Control



func _on_return_button_pressed() -> void:
	GlobalMap.close_map.emit()
