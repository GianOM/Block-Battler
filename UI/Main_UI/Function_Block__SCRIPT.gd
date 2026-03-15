extends Control

enum Block_State{
	AVAILABLE,
	BLOCKED,
	DRAGGABLE,
	DRAGGING,
	
}

@onready var f_block_texture: TextureRect = $FBlock_TEXTURE


var current_state: Block_State = Block_State.AVAILABLE

func _ready() -> void:
	
	
	print_tree()
	
	JOGADOR.Left_Click_Pressed.connect(_on_Player_PRESSED_Left_Click)
	JOGADOR.Left_Click_Released.connect(_on_Player_RELEASED_Left_Click)
	
	
	
func _physics_process(delta: float) -> void:
	if current_state == Block_State.DRAGGING:
		
		#Centraliza e nao deixa sair da tela
		f_block_texture.global_position = (get_global_mouse_position() - (size/2)).clamp(Vector2.ZERO, get_viewport().get_visible_rect().size - (size))



func _on_Player_PRESSED_Left_Click():
	
	if current_state == Block_State.DRAGGABLE:
		current_state = Block_State.DRAGGING
		
		print("Mouse DRAGGING")
		
func _on_Player_RELEASED_Left_Click():
	
	
	if current_state == Block_State.DRAGGING:
		current_state = Block_State.DRAGGABLE
		
		f_block_texture.position = Vector2.ZERO
		
		print("Mouse FINISHED DRAGGIN")


func _on_mouse_entered_area():
	
	
	if current_state == Block_State.AVAILABLE:
	
		mouse_default_cursor_shape = Control.CURSOR_DRAG
		current_state = Block_State.DRAGGABLE
		
		print("Mouse ON")
	
	
func _on_mouse_exited_area():
	
	# Se ele nao esta sendo arrastado, nao tiramos ele do Draggable State
	if current_state == Block_State.DRAGGABLE:
	
	
		mouse_default_cursor_shape = Control.CURSOR_ARROW
		
		current_state = Block_State.AVAILABLE
	
