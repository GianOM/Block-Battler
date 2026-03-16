extends Node


@warning_ignore("unused_signal")
signal Left_Click_Pressed

@warning_ignore("unused_signal")
signal Left_Click_Released


var current_Function_Dragging_Block: Function_Block = null


func Set_Block_Dropable():
	if current_Function_Dragging_Block != null:
		current_Function_Dragging_Block.Set_Block_Dropable()
func Set_Block_Dragging():
	if current_Function_Dragging_Block != null:
		current_Function_Dragging_Block.Set_Block_Dropable()
