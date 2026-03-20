class_name Attachment_Manager extends Control



# Ponteiro que aponta para o Rott
@export var ptr_Root_Block: Universal_Block



enum Attach_Position{
	UP,
	DOWN,
	LEFT,
	RIGHT,
	NONE
}


var current_attach_position: Attach_Position = Attach_Position.NONE


func _on_mouse_enter_UP_area():
	
	if JOGADOR.current_Function_Dragging_Block == null:
		return
		
		
	current_attach_position = Attach_Position.UP
	JOGADOR.current_Function_Attach_Block = ptr_Root_Block
	
	
	
	
	
func _on_mouse_leave_UP_area():
	
	JOGADOR.current_Function_Attach_Block = null
	current_attach_position = Attach_Position.NONE
	
	
func _on_mouse_enter_DOWN_area():
	
	
	if JOGADOR.current_Function_Dragging_Block == null:
		return
		
	current_attach_position = Attach_Position.DOWN
	JOGADOR.current_Function_Attach_Block = ptr_Root_Block
	
	
	
	
	
func _on_mouse_leave_DOWN_area():
	
	JOGADOR.current_Function_Attach_Block = null
	current_attach_position = Attach_Position.NONE
		
	
	
func _on_mouse_enter_LEFT_area():
	
	
	if JOGADOR.current_Function_Dragging_Block == null:
		return
		
	current_attach_position = Attach_Position.LEFT
	JOGADOR.current_Function_Attach_Block = ptr_Root_Block
	
	
	
func _on_mouse_leave_LEFT_area():
	
	JOGADOR.current_Function_Attach_Block = null
	current_attach_position = Attach_Position.NONE
	
	
	
func _on_mouse_enter_RIGHT_area():
	
	
	if JOGADOR.current_Function_Dragging_Block == null:
		return
		
		
	current_attach_position = Attach_Position.RIGHT
	JOGADOR.current_Function_Attach_Block = ptr_Root_Block
	
	
func _on_mouse_leave_RIGHT_area():
	
	JOGADOR.current_Function_Attach_Block = null
	current_attach_position = Attach_Position.NONE
	
	
	
	
	
