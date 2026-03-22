extends Node



@warning_ignore("unused_signal")
signal Left_Click_Pressed

@warning_ignore("unused_signal")
signal Left_Click_Released



@warning_ignore("unused_signal")
signal Player_Mouse_Entered_Canvas

@warning_ignore("unused_signal")
signal Player_Mouse_Left_Canvas

@warning_ignore("unused_signal")
signal Player_Connected_Blocks(Block_Group: Universal_Block)




var current_Function_Dragging_Block: Universal_Block = null
var current_Function_Attach_Block: Universal_Block = null
