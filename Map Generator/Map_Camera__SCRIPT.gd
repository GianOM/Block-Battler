extends Camera3D

# Os valores abaixo mudam de acordo com a altitude
var Mouse_Zoom_Speed: float = 36
var Mouse_Panning_Speed: float = 0.05

var is_holding_left_click: bool = false


func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		
		if event.is_pressed():
			match event.button_index:
				MouseButton.MOUSE_BUTTON_WHEEL_UP:
					position.y -= Mouse_Zoom_Speed
					
					Mouse_Panning_Speed = position.y / 10000
					Mouse_Zoom_Speed = position.y / 14
					
					#print(Mouse_Panning_Speed)
					
				MouseButton.MOUSE_BUTTON_WHEEL_DOWN:
					position.y += Mouse_Zoom_Speed
					
					Mouse_Panning_Speed = position.y / 10000
					Mouse_Zoom_Speed = position.y / 14
					
					#print(Mouse_Panning_Speed)
					
				MouseButton.MOUSE_BUTTON_LEFT:
					is_holding_left_click = true
					
		else:
			match event.button_index:
				MouseButton.MOUSE_BUTTON_LEFT:
					is_holding_left_click = false
					
	elif event is InputEventMouseMotion:
		if is_holding_left_click:
			
			var Mouse_Movement_Velocity: Vector2 = event.get_screen_relative() * Mouse_Panning_Speed
			
			
			
			position.x -= Mouse_Movement_Velocity.x
			position.z -= Mouse_Movement_Velocity.y
		
