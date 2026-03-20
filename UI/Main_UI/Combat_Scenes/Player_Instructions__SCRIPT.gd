extends VBoxContainer




func Make_Command_from_Instructions(instructions_text: String):
	
	var Temp_Label: Label = Label.new()
	
	Temp_Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	Temp_Label.text = instructions_text
	
	add_child(Temp_Label)
	
	
