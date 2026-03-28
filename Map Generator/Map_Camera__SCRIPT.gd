extends Camera3D

# Os valores abaixo mudam de acordo com a altitude
var Mouse_Zoom_Speed: float = 36
var Mouse_Panning_Speed: float = 0.05

var is_holding_left_click: bool = false

var Screen_Size: Vector2 = DisplayServer.screen_get_size()


func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		
		if event.is_pressed():
			match event.button_index:
				MouseButton.MOUSE_BUTTON_WHEEL_UP:
					
					var Mouse_Direction_to_Screen_Center: Vector2 = (event.position - (Screen_Size/2)).normalized()
					
					position.y -= Mouse_Zoom_Speed
					position.x += Mouse_Direction_to_Screen_Center.x * Mouse_Panning_Speed * 25
					position.z += Mouse_Direction_to_Screen_Center.y * Mouse_Panning_Speed * 25
					
					print(Mouse_Direction_to_Screen_Center)
					
					
					
					Mouse_Panning_Speed = position.y / 10000
					Mouse_Zoom_Speed = position.y / 14
					
					
					
				MouseButton.MOUSE_BUTTON_WHEEL_DOWN:
					
					var Mouse_Direction_to_Screen_Center: Vector2 = (event.position - (Screen_Size/2)).normalized()
					position.y += Mouse_Zoom_Speed
					#position.x += Mouse_Direction_to_Screen_Center.x
					#position.z += Mouse_Direction_to_Screen_Center.y
					
					
					#print(Mouse_Direction_to_Screen_Center)
					
					Mouse_Panning_Speed = position.y / 10000
					Mouse_Zoom_Speed = position.y / 14
					
					
					
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
		
