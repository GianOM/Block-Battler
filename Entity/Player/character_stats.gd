class_name CharacterStats
extends EntityStats

#TBD... energy, starting array of func blocks etc

@export var my_block_list: PackedScene

func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.hp = max_hp
	instance.shield = 0
	return instance
