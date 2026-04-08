class_name CharacterStats
extends EntityStats

#TBD... energy, starting array of func blocks etc

@export var starter_pile: FBlockPile

func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.hp = max_hp
	instance.shield = 0
	return instance
