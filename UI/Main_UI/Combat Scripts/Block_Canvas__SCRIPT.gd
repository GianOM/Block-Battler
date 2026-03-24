extends Control


var is_mouse_on_Canvas: bool = false




func _ready() -> void:
	JOGADOR.Player_Dropped_Block_on_Canvas.connect(Drop_Block_on_Canvas_Grid)



func _on_Mouse_Entered_Canvas():
	
	is_mouse_on_Canvas = true
	
	JOGADOR.Player_Mouse_Entered_Canvas.emit()
	
	
	
func _on_Mouse_Leave_Canvas():
	
	is_mouse_on_Canvas = false
	
	JOGADOR.Player_Mouse_Left_Canvas.emit()
	
	
	
	
func Drop_Block_on_Canvas_Grid(block_to_drop: Universal_Block):
	var relative_position: Vector2 = global_position - block_to_drop.block_texture.global_position
	
	
	var discrete_position: Vector2i = Vector2i(floori(relative_position.x / 132), floori(relative_position.y / 100))
	
	
	
	discrete_position = discrete_position.clamp(Vector2i(0,0),Vector2i(99,99))
	
	var final_position: Vector2 = global_position + Vector2(discrete_position.x * 132, discrete_position.y*100)
	
	
	print(discrete_position)
	
	block_to_drop.block_texture.global_position = final_position
	
	
	
	
	
	
	
