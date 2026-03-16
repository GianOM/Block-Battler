class_name Function_Block extends Control

enum Block_State{
	ONLIST,
	ONCANVAS,
	DRAGGABLE,
	DRAGGING,
	DROPABLE,
	PLACED
}

@onready var f_block_texture: TextureRect = $FBlock_TEXTURE

var current_state: Block_State = Block_State.ONLIST

func _ready() -> void:
	
	
	print_tree()
	
	JOGADOR.Left_Click_Pressed.connect(_on_Player_PRESSED_Left_Click)
	JOGADOR.Left_Click_Released.connect(_on_Player_RELEASED_Left_Click)
	
	
	
func _physics_process(delta: float) -> void:
	
	print(name + " -> " + Block_State.keys()[current_state])
	
	if (current_state == Block_State.DRAGGING) or (current_state == Block_State.DROPABLE):
		#																				Centraliza e nao deixa sair da tela
		f_block_texture.global_position = (get_global_mouse_position() - (size/2)).clamp(Vector2.ZERO, get_viewport().get_visible_rect().size - (size))
		
		
		
func Set_Block_Dropable():
	current_state = Block_State.DROPABLE
	
func Set_Block_Dragging():
	current_state = Block_State.DRAGGING



func _on_Player_PRESSED_Left_Click():
	
	# Significa que ele ja esta carregando um bloco por vez
	if JOGADOR.current_Function_Dragging_Block != null:
		return
	
	if current_state == Block_State.DRAGGABLE:
		
		current_state = Block_State.DRAGGING
		JOGADOR.current_Function_Dragging_Block = self
		
		
	elif (current_state == Block_State.ONCANVAS):
		
		current_state = Block_State.DROPABLE
		JOGADOR.current_Function_Dragging_Block = self
		
		
func _on_Player_RELEASED_Left_Click():
	
	JOGADOR.current_Function_Dragging_Block = null
	
	if current_state == Block_State.DRAGGING:
		
		current_state = Block_State.DRAGGABLE
		f_block_texture.position = Vector2.ZERO
		
		
	elif current_state == Block_State.DROPABLE:
		
		current_state = Block_State.ONCANVAS
		


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
	
