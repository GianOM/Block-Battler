extends VBoxContainer




func Make_Command_from_Instructions(instructions_text: String):
	
	var Temp_Label: RichTextLabel = RichTextLabel.new()
	Temp_Label.set_fit_content(true)
	Temp_Label.text = instructions_text
	
	
	add_child(Temp_Label)
	
	
	
func Erase_Command_from_ID(instruction_id_to_free: int):
	
	for instruction in get_children():
		
		var child_instruction: String = instruction.text.split("-",false)[0]
		
		
		
		if child_instruction == str(instruction_id_to_free):
			instruction.queue_free()
			return
		
		
		
	push_warning("Instruction ID Not found")
	
	
	
	
	
	
	
	
	
