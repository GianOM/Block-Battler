extends Control



#Se o player ficar hoverando um bloco

@onready var tool_tip_text: RichTextLabel = $"Panel/Black_Panel/ToolTip Text"
@onready var time_hovering_block: Timer = $Time_Hovering_Block

func _ready() -> void:
	COMBATE.ToolTip_Requested.connect(_on_Tooltip_Requested)





func _on_Tooltip_Requested(block_to_display_info: Universal_Block):
	
	tool_tip_text.text = block_to_display_info.Block_Tooltip_Description
	
	global_position = block_to_display_info.global_position
	
	global_position.x -= size.x * 1.2
	
	show()
	
	
	
	pass
