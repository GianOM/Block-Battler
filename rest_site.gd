extends Control


func _on_button_pressed() -> void:
	GlobalMap.rest_site_exited.emit()
