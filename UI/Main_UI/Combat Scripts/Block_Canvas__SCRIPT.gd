extends Control


var is_mouse_on_Canvas: bool = false


@onready var block_grid: GridContainer = $Panel/Block_Grid

const CANVAS_GRID_CELL__SCENE = preload("uid://tmolln28ufc4")

var Last_Hovered_Grid_Cells: Array[Canvas_Grid_Cell]


func _ready() -> void:
	
	JOGADOR.Player_Dropped_Block_on_Canvas.connect(Drop_Block_on_Canvas_Grid)
	COMBATE.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
	for i in range(12):
		
		var Temp_Canvas_Grid: Canvas_Grid_Cell = CANVAS_GRID_CELL__SCENE.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
		
		block_grid.add_child(Temp_Canvas_Grid)
		
		Temp_Canvas_Grid.Player_Hovering_Cell.connect(_on_Player_HOVERED_a_Grid_Cell)
		Temp_Canvas_Grid.Player_Unhovered_Cell.connect(_on_Player_UNHOVERED_a_Grid_Cell)
		
		
func _on_enemy_turn_ended():
	for Temp_Canvas_Grid in block_grid.get_children():
		Temp_Canvas_Grid.Cooldown()
		
		
func _on_Player_HOVERED_a_Grid_Cell(ptr_Grid_Cell: Canvas_Grid_Cell):
	
	Last_Hovered_Grid_Cells.push_back(ptr_Grid_Cell)
	
func _on_Player_UNHOVERED_a_Grid_Cell(ptr_Grid_Cell: Canvas_Grid_Cell):
	
	Last_Hovered_Grid_Cells.erase(ptr_Grid_Cell)
	
	
	
		
	
	



func _on_Mouse_Entered_Canvas():
	
	is_mouse_on_Canvas = true
	JOGADOR.Player_Mouse_Entered_Canvas.emit()
	
	
	
func _on_Mouse_Leave_Canvas():
	
	is_mouse_on_Canvas = false
	JOGADOR.Player_Mouse_Left_Canvas.emit()
	
	
	
	
func Drop_Block_on_Canvas_Grid(block_to_drop: Universal_Block):
	
	
	if Last_Hovered_Grid_Cells.size() == 0:
		
		block_to_drop.RESET()
		
		return
		
		
		
	block_to_drop.block_texture.global_position = Last_Hovered_Grid_Cells[-1].global_position
	
	block_to_drop.current_state = Universal_Block.Block_State.ONCANVAS
	block_to_drop.current_grid_cell = Last_Hovered_Grid_Cells[-1]
	
	
	Last_Hovered_Grid_Cells[-1].Disable_Canvas_Slot()
	
	return
	
	
