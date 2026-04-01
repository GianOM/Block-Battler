class_name Variables_Block extends Universal_Block

enum Block_Type{
	ENEMY,
	ALLY
}
var current_state: Block_State = Block_State.ONLIST
var Block_Target: String

@export var my_block_type: Block_Type
@export var Possible_Attachment_Sides: Array[String]

@onready var block_texture: TextureRect = $VBlock_TEXTURE
@onready var block_attachment_manager: Attachment_Manager = $VBlock_TEXTURE/Block_Attachment_Manager

@onready var block_id: Label = $VBlock_TEXTURE/Block_ID

var Parents_Blocks_List: Array[Function_Block]



var current_grid_cell: Canvas_Grid_Cell


var is_mouse_on_Canvas: bool = false


func _ready() -> void:
	
	_connect_signals()
	_initialize_block()
	
	
func _connect_signals() -> void:
	
	JOGADOR.Left_Click_Pressed.connect(_on_Player_PRESSED_Left_Click)
	JOGADOR.Left_Click_Released.connect(_on_Player_RELEASED_Left_Click)
	
	JOGADOR.Player_Mouse_Entered_Canvas.connect(Set_Block_Dropable)
	JOGADOR.Player_Mouse_Left_Canvas.connect(Set_Block_Dragging)
	
	COMBATE.player_turn_ended.connect(RESET)
	
func _initialize_block():
	
	block_texture.Set_Correct_Block_Texture(my_block_type)
	block_attachment_manager.Set_Up_Block_Sides(Possible_Attachment_Sides)
	
	
	
	
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	#print(name + " -> " + Block_State.keys()[current_state])
	
	if (current_state == Block_State.DRAGGING) or (current_state == Block_State.DROPABLE):
		
		#Centraliza e nao deixa sair da tela
		block_texture.global_position = (get_global_mouse_position() - (size/2)).clamp(Vector2.ZERO, get_viewport().get_visible_rect().size - (size))
		
		
		
		
		
		
		
		
		
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
	
	if current_state == Block_State.DRAGGABLE:
		
		current_state = Block_State.DRAGGING
		block_texture.modulate = Color(1.0, 1.0, 1.0, 1.0)
		
		JOGADOR.current_Function_Dragging_Block = self
		
		
	elif (current_state == Block_State.ONCANVAS):
		
		if is_mouse_on_Canvas:
			
			#Pegamos um bloco que ja foi colocado em um slot, logo precisamos resetar o canvas slot
			#e limpar qualquer conexao feita com outros blocos
		
			current_state = Block_State.DROPABLE
			JOGADOR.current_Function_Dragging_Block = self
			
			current_grid_cell.Enable_Canvas_Slot()
			Clear_Block_Connections()
			
			
		else:
			
			current_state = Block_State.DRAGGING
			JOGADOR.current_Function_Dragging_Block = self
		
		
func _on_Player_RELEASED_Left_Click():
	
	JOGADOR.current_Function_Dragging_Block = null
	
	
	block_texture.z_index = 32
	
	if current_state == Block_State.DRAGGING:
		RESET()
		
		
	elif current_state == Block_State.DROPABLE:
		current_state = Block_State.ONCANVAS
		# Se nao estiver nenhum bloco adjacente, so solta
		if JOGADOR.current_Function_Attach_Block == null:
			
			JOGADOR.Player_Dropped_Block_on_Canvas.emit(self)
			
		else:
			# Se soltarmos proxima a uma regiao de attachment, fazemos o attachment
			# do atual bloco sendo arrastado ao bloco "attach target"
			
			JOGADOR.Player_Dropped_Block_on_Canvas.emit(self)
			JOGADOR.current_Function_Attach_Block.Attach_Function_Block_to_Self(self)
			
		


func _on_mouse_entered_area():
	
	if (current_state == Block_State.ONLIST):
		current_state = Block_State.DRAGGABLE
		
	elif (current_state == Block_State.PLACED):
		current_state = Block_State.ONCANVAS
	
	
func _on_mouse_exited_area():
	
	# Se ele nao esta sendo arrastado, nao tiramos ele do Draggable State
	if current_state == Block_State.DRAGGABLE:
		current_state = Block_State.ONLIST
		
	elif current_state == Block_State.ONCANVAS:
		current_state = Block_State.PLACED
		
		
		
func Set_Block_ID(input_text: String):
	
	block_id.text = input_text
	block_id.show()
	Block_Target = input_text
	
	
	
	
	
	
func Clear_Block_Connections():
	
	
	# Debug ONly
	for parent_block in Parents_Blocks_List:
		
		if parent_block:
			
			JOGADOR.Player_Disconnected_Blocks.emit(parent_block)
			parent_block.Erase_Block_Connection(self)
			#print("Removed Connection with : " + parent_block.name)
	
	
	Parents_Blocks_List.clear()
	
	
func RESET():
	current_state = Block_State.ONLIST
	block_texture.position = Vector2.ZERO
	block_texture.modulate = Color(1.0, 1.0, 1.0, 0.0)
	
	Clear_Block_Connections()
	
