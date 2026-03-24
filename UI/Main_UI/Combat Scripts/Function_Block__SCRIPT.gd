class_name Function_Block extends Universal_Block

enum Block_State{
	ONLIST,
	ONCANVAS,
	DRAGGABLE,
	DRAGGING,
	DROPABLE,
	PLACED,
	ATTACHED
}

enum Block_Type{
	ATTACK,
	DEFENSE,
	LOOP
}

@export var my_block_type: Block_Type
@export var Possible_Attachment_Sides: Array[String]

@export var variable_number: int

@onready var block_texture: TextureRect = $FBlock_TEXTURE
@onready var block_attachment_manager: Attachment_Manager = $FBlock_TEXTURE/Block_Attachment_Manager


var Child_Blocks: Array[Universal_Block]

var current_state: Block_State = Block_State.ONLIST

var is_mouse_on_Canvas: bool = false

func _ready() -> void:
	
	JOGADOR.Left_Click_Pressed.connect(_on_Player_PRESSED_Left_Click)
	JOGADOR.Left_Click_Released.connect(_on_Player_RELEASED_Left_Click)
	
	JOGADOR.Player_Mouse_Entered_Canvas.connect(Set_Block_Dropable)
	JOGADOR.Player_Mouse_Left_Canvas.connect(Set_Block_Dragging)
	
	block_texture.Set_Correct_Block_Texture(my_block_type)
	
	block_attachment_manager.Set_Up_Block_Sides(Possible_Attachment_Sides)
	
	

	
	
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	#print(name + " -> " + Block_State.keys()[current_state])
	
	if (current_state == Block_State.DRAGGING) or (current_state == Block_State.DROPABLE):
		#																				Centraliza e nao deixa sair da tela
		block_texture.global_position = (get_global_mouse_position() - (size/2)).clamp(Vector2.ZERO, get_viewport().get_visible_rect().size - (size))
		
		
		
		
		
		
# A entrada é o bloco que esta sendo arrastado
func Attach_Function_Block_to_Self(block_to_attach: Universal_Block):
	
	Child_Blocks.append(block_to_attach)
	
	#Coloca um bloco sobre o outro e mais embaixo so adiciona um offset
	#block_to_attach.block_texture.global_position = block_texture.global_position
	#
	#
	#
	#match block_attachment_manager.current_attach_position:
		#Attachment_Manager.Attach_Position.UP:
			#
			#block_to_attach.block_texture.global_position.y -= size.y * 0.5
			#
		#Attachment_Manager.Attach_Position.DOWN:
			#
			#block_to_attach.block_texture.global_position.y += size.y * 0.5
			#
		#Attachment_Manager.Attach_Position.RIGHT:
			#
			#block_to_attach.block_texture.global_position.x += (size.x * 0.85)
			#
			#
		#Attachment_Manager.Attach_Position.LEFT:
			#
			#block_to_attach.block_texture.global_position.x -= size.x
			
		
	
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
	
	if current_state == Block_State.DRAGGABLE:
		
		current_state = Block_State.DRAGGING
		JOGADOR.current_Function_Dragging_Block = self
		
		
	elif (current_state == Block_State.ONCANVAS):
		
		if is_mouse_on_Canvas:
		
			current_state = Block_State.DROPABLE
			JOGADOR.current_Function_Dragging_Block = self
			
		else:
			
			current_state = Block_State.DRAGGING
			JOGADOR.current_Function_Dragging_Block = self
		
		
func _on_Player_RELEASED_Left_Click():
	
	JOGADOR.current_Function_Dragging_Block = null
	
	if current_state == Block_State.DRAGGING:
		
		current_state = Block_State.DRAGGABLE
		block_texture.position = Vector2.ZERO
		
		
	elif current_state == Block_State.DROPABLE:
		
		# Se nao estiver nenhum bloco adjacente, so solta
		if JOGADOR.current_Function_Attach_Block == null:
			
			current_state = Block_State.ONCANVAS
			
			JOGADOR.Player_Dropped_Block_on_Canvas.emit(self)
			
		else:
			# Se soltarmos proxima a uma regiao de attachment, fazemos o attachment
			# do atual bloco sendo arrastado ao bloco "attach target"
			
			current_state = Block_State.ATTACHED
			
			Attach_Function_Block_to_Self(JOGADOR.current_Function_Attach_Block)
			
			JOGADOR.Player_Dropped_Block_on_Canvas.emit(self)
			
		


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
		
		
		
		
		
		
		
		
		
		
func RESET():
	
	current_state = Block_State.ONLIST
	block_texture.position = Vector2.ZERO
	
	Child_Blocks.clear()
		
	
