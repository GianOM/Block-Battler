extends Node2D

@onready var entity: Enemy = $EntityUI

var shield = Shield.new()
var damage = Damage.new()



func _ready() -> void:
	
	#shield.amount = 300
	#shield.execute(entity)
	
	
	COMBATE.Instructions_Push.connect(Task_List)
	
	
func Task_List(instructions_array: Array[String]):
	
	
	for single_task in instructions_array:
		if single_task.contains("ATT"):
			
			var Task_Details: PackedStringArray = single_task.split("-")
			
			
			if not entity:
				return
			
			damage.amount = int(Task_Details[-1])
			damage.execute(entity)
			
		
	
