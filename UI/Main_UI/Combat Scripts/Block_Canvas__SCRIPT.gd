extends Control


var is_mouse_on_Canvas: bool = false


@onready var block_grid: GridContainer = $Panel/Block_Grid

const CANVAS_GRID_CELL__SCENE = preload("uid://tmolln28ufc4")

var Currently_Hovered_Grid_Cell: Canvas_Grid_Cell


func _ready() -> void:
	JOGADOR.Player_Dropped_Block_on_Canvas.connect(Drop_Block_on_Canvas_Grid)
	
	
	for i in range(99):
		
		var Temp_Canvas_Grid: Canvas_Grid_Cell = CANVAS_GRID_CELL__SCENE.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
		
		block_grid.add_child(Temp_Canvas_Grid)
		
		Temp_Canvas_Grid.Player_Hovering_Cell.connect(_on_Player_Hovered_a_Grid_Cell)
		
		
		
		
func _on_Player_Hovered_a_Grid_Cell(ptr_Grid_Cell:Canvas_Grid_Cell):
	
	Currently_Hovered_Grid_Cell = ptr_Grid_Cell
		
	
	



func _on_Mouse_Entered_Canvas():
	
	is_mouse_on_Canvas = true
	
	JOGADOR.Player_Mouse_Entered_Canvas.emit()
	
	
	
func _on_Mouse_Leave_Canvas():
	
	is_mouse_on_Canvas = false
	
	JOGADOR.Player_Mouse_Left_Canvas.emit()
	
	
	
	
func Drop_Block_on_Canvas_Grid(block_to_drop: Universal_Block):
	
	
	if Currently_Hovered_Grid_Cell == null:
		return
		
		#print(Currently_Hovered_Grid_Cell.global_position)
		
		
		
	#print()
		
		
		
	block_to_drop.block_texture.global_position = Currently_Hovered_Grid_Cell.global_position
	
	return
	
	
	
	var relative_position: Vector2 = block_to_drop.block_texture.global_position - global_position
	
	#print(floori(relative_position.x / 132))
	
	
	var discrete_position: Vector2i = Vector2i(floori(relative_position.x / 132), floori(relative_position.y / 100))
	
	discrete_position = discrete_position.clamp(Vector2i(0,0),Vector2i(99,99))
	
	var final_position: Vector2 = global_position + Vector2(discrete_position.x * 132, discrete_position.y*100)
	
	
	print(discrete_position)
	
	block_to_drop.block_texture.global_position = final_position
	
	
	
	
	
	
	
