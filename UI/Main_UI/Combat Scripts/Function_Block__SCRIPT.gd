class_name Function_Block extends Universal_Block




var My_Block_Data: FBlock_Data : set = initialize_block_data
@export var variable_number: int

@onready var block_texture: TextureRect = $FBlock_TEXTURE
@onready var block_attachment_manager: Attachment_Manager = $FBlock_TEXTURE/Block_Attachment_Manager

var current_grid_cell: Canvas_Grid_Cell

var Child_Blocks: Array[Universal_Block]

var current_state: Block_State = Block_State.ONLIST

var is_mouse_on_Canvas: bool = false

func _ready() -> void:
	
	_connect_signals()
	#_initialize_block(My_Block_Data)
	

	
	
func _connect_signals() -> void:
	
	JOGADOR.Left_Click_Pressed.connect(_on_Player_PRESSED_Left_Click)
	JOGADOR.Left_Click_Released.connect(_on_Player_RELEASED_Left_Click)
	
	JOGADOR.Player_Mouse_Entered_Canvas.connect(Set_Block_Dropable)
	JOGADOR.Player_Mouse_Left_Canvas.connect(Set_Block_Dragging)
	
	
func initialize_block_data(Block_Data: FBlock_Data):
	if not is_node_ready():
		await ready
	
	block_texture.Set_Correct_Block_Texture(Block_Data)
	block_attachment_manager.Set_Up_Block_Sides(Block_Data.attachment_sides)
	
	My_Block_Data = Block_Data
	
	My_Block_Data.id = str(get_instance_id())
	
	
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	#print(name + " -> " + Block_State.keys()[current_state])
	
	if (current_state == Block_State.DRAGGING) or (current_state == Block_State.DROPABLE):
		#Centraliza e nao deixa sair da tela
		block_texture.global_position = (get_global_mouse_position() - (size/2)).clamp(Vector2.ZERO, get_viewport().get_visible_rect().size - (size))
		
		
		
		
		
		
func Check_Blocks_Compatibility(block_to_test: Universal_Block) -> bool:
	
	
	if My_Block_Data.attachment_sides.has("UP") and block_to_test.Possible_Attachment_Sides.has("DOWN"):
		return true
	elif My_Block_Data.attachment_sides.has("DOWN") and block_to_test.Possible_Attachment_Sides.has("UP"):
		return true
		
	elif My_Block_Data.attachment_sides.has("RIGHT") and block_to_test.Possible_Attachment_Sides.has("LEFT"):
		return true
	elif My_Block_Data.attachment_sides.has("LEFT") and block_to_test.Possible_Attachment_Sides.has("RIGHT"):
		return true
	
	
	
	return false
		
		
# A entrada é o bloco que esta sendo arrastado
func Attach_Function_Block_to_Self(block_to_attach: Universal_Block):
	
	
	if Check_Blocks_Compatibility(block_to_attach):
		
	
		Child_Blocks.append(block_to_attach)
		block_to_attach.Parents_Blocks_List.append(self)
		
		JOGADOR.Player_Connected_Blocks.emit(self)
	
		
		
func Set_Block_Dropable():
	
	is_mouse_on_Canvas = true
	
	if current_state == Block_State.DRAGGING:
		current_state = Block_State.DROPABLE
		
		
	
func Set_Block_Dragging():
	
	is_mouse_on_Canvas = false
	
	if current_state == Block_State.DROPABLE:
		current_state = Block_State.DRAGGING



func _on_Player_PRESSED_Left_Click():
	
	# Significa que ele ja esta carregando um bloco por vez
	if JOGADOR.current_Function_Dragging_Block != null:
		return
	
	block_texture.z_index = 64
	COMBATE.ToolTip_Hide_Requested.emit()
	
	
	if current_state == Block_State.DRAGGABLE:
		
		current_state = Block_State.DRAGGING
		JOGADOR.current_Function_Dragging_Block = self
		
		
	elif (current_state == Block_State.ONCANVAS):
		
		if Child_Blocks.size() > 0:
			
			JOGADOR.Player_Disconnected_Blocks.emit(self)
			
			Clear_Block_Connections()
			
		if is_mouse_on_Canvas:
		
			current_state = Block_State.DROPABLE
			JOGADOR.current_Function_Dragging_Block = self
			
			current_grid_cell.Enable_Canvas_Slot()
			
			
		else:
			
			current_state = Block_State.DRAGGING
			JOGADOR.current_Function_Dragging_Block = self
		
		
func _on_Player_RELEASED_Left_Click():
	
	block_texture.z_index = 32
	JOGADOR.current_Function_Dragging_Block = null
	
	
	
	if current_state == Block_State.DRAGGING:
		
		RESET()
		
		
	elif current_state == Block_State.DROPABLE:
		# Se nao estiver nenhum bloco adjacente, so solta
		if JOGADOR.current_Function_Attach_Block == null:
			
			#current_state = Block_State.DRAGGABLE
			#block_texture.position = Vector2.ZERO
			
			JOGADOR.Player_Dropped_Block_on_Canvas.emit(self)
			
		else:
			# Se soltarmos proxima a uma regiao de attachment, fazemos o attachment
			# do atual bloco sendo arrastado ao bloco "attach target"
			current_state = Block_State.ONCANVAS
			Attach_Function_Block_to_Self(JOGADOR.current_Function_Attach_Block)
			JOGADOR.Player_Dropped_Block_on_Canvas.emit(self)
			
		


func _on_mouse_entered_area():
	
	COMBATE.ToolTip_Requested.emit(self)
	
	if (current_state == Block_State.ONLIST):
		current_state = Block_State.DRAGGABLE
	elif (current_state == Block_State.PLACED):
		current_state = Block_State.ONCANVAS
	
	
func _on_mouse_exited_area():
	
	COMBATE.ToolTip_Hide_Requested.emit()
	
	# Se ele nao esta sendo arrastado, nao tiramos ele do Draggable State
	if current_state == Block_State.DRAGGABLE:
		current_state = Block_State.ONLIST
		
	elif current_state == Block_State.ONCANVAS:
		current_state = Block_State.PLACED
		
		
		
		
		
		
		
func Erase_Block_Connection(block_to_erase: Universal_Block):
	Child_Blocks.erase(block_to_erase)
		
		
		
		
func Clear_Block_Connections():
	
	# Debug ONly
	for child_block in Child_Blocks:
		if child_block:
		
			print("Removed Connection with : " + child_block.name)
		
	Child_Blocks.clear()
		
		
		
		
		
func RESET():
	
	current_state = Block_State.ONLIST
	block_texture.position = Vector2.ZERO
	
	Clear_Block_Connections()
	
	if current_grid_cell:
		current_grid_cell.Enable_Canvas_Slot()
		pass
		
	
