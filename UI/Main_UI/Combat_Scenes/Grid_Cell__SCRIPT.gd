class_name Canvas_Grid_Cell extends Panel


enum Grid_Cell_State{
	ENABLED,
	DISABLED,
	ONCOOLDOWN
}

signal Player_Hovering_Cell
signal Player_Unhovered_Cell


@onready var canvas_grid_cell_hitbox: Area2D = $Canvas_Grid_Cell_HITBOX
@onready var cooldown_label: Label = $Cooldown_Label

var turns_cooldown: int = 0
var My_State: Grid_Cell_State = Grid_Cell_State.ENABLED


func Disable_Canvas_Slot():
	
	canvas_grid_cell_hitbox.hide()
	#WARNING: Nao podemosar usar hide e show ainda para esconder o Block Slot
	self_modulate = Color(1.0, 1.0, 1.0, 0.0)
	My_State = Grid_Cell_State.DISABLED
	
func Enable_Canvas_Slot():
	
	canvas_grid_cell_hitbox.show()
	self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	My_State = Grid_Cell_State.ENABLED
	
	
func Cooldown():
	
	match My_State:
		Canvas_Grid_Cell.Grid_Cell_State.DISABLED:
			turns_cooldown = 3
			cooldown_label.text = "Turns Cooldown:\n" + str(turns_cooldown)
			My_State = Grid_Cell_State.ONCOOLDOWN
			
			cooldown_label.show()
		Canvas_Grid_Cell.Grid_Cell_State.ONCOOLDOWN: 
			turns_cooldown -= 1
			
			if turns_cooldown == 0:
				Enable_Canvas_Slot()
				cooldown_label.hide()
				return
				
				
			cooldown_label.text = "Turns Cooldown:\n" + str(turns_cooldown)
				
			




func _on_Mouse_ENTER_Hitbox():
	
	
	Player_Hovering_Cell.emit(self)
	
	
func _on_Mouse_LEAVE_Hitbox():
	
	
	Player_Unhovered_Cell.emit(self)
	
	
	
