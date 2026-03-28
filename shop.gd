extends Control



func _on_button_pressed() -> void:
	GlobalMap.shop_exited.emit()
