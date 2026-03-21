extends VBoxContainer




func Make_Command_from_Instructions(instructions_text: String):
	
	var Temp_Label: Label = Label.new()
	
	Temp_Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
	Temp_Label.text = instructions_text
	
	add_child(Temp_Label)
	
	
	
	
func Push_Turn_Actions():
	
	
	var Temp_Array : Array[String]
	
	
	
	for i in range(get_child_count()):
		
		Temp_Array.push_back(get_child(i).text)
		
		
	COMBATE.Instructions_Push.emit(Temp_Array)
	
	
