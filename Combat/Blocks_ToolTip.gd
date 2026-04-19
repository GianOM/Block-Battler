extends Control



#Se o player ficar hoverando um bloco

@onready var tool_tip_text: RichTextLabel = $"Panel/Black_Panel/ToolTip Text"
@onready var time_hovering_block: Timer = $Time_Hovering_Block

func _ready() -> void:
	
	
	
	COMBATE.ToolTip_Requested.connect(_on_Tooltip_Requested)
	COMBATE.ToolTip_Hide_Requested.connect(_on_ToolTip_Hide_Requested)
	
	
func _on_Tooltip_Requested(block_to_display_info: Universal_Block):
	
	tool_tip_text.text = block_to_display_info.My_Block_Data.tooltip
	
	match block_to_display_info.current_state:
		
		Universal_Block.Block_State.DRAGGABLE:
			global_position = block_to_display_info.block_texture.global_position
			global_position.x -= 132 * 2.5
			
		Universal_Block.Block_State.ONCANVAS:
			global_position = block_to_display_info.block_texture.global_position
			global_position.x += 132 * 1.0
	
	
	
	show()
	
	
func _on_ToolTip_Hide_Requested():
	
	hide()
	
