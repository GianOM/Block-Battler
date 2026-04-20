class_name FunctionBlockSimplifiedUI
extends Button

@export var fblock: FBlock_Data: set = set_fblock_data

@onready var f_block_texture: FuntionBlockTextureScript = %FBlock_TEXTURE
@onready var details_text: RichTextLabel = %"Details Text"


func set_fblock_data(value: FBlock_Data):
	if not is_node_ready():
		await ready
	
	fblock = value
	f_block_texture.Set_Correct_Block_Texture(value)
	#details_text.text = str(fblock.Block_Type.keys()[fblock.my_block_type])

func _on_f_block_ui_mouse_entered() -> void:
	pass # Replace with function body.


func _on_f_block_ui_mouse_exited() -> void:
	pass # Replace with function body.



func _on_pressed() -> void:
	queue_free()
