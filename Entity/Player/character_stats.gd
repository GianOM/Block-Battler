class_name CharacterStats
extends EntityStats

#TBD... energy, starting array of func blocks etc

@export var starter_pile: FBlockPile

var run_pile: FBlockPile
var draw_pile: FBlockPile
var discard_pile: FBlockPile

func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.hp = max_hp
	instance.shield = 0
	instance.run_pile = instance.starter_pile.duplicate()
	instance.draw_pile = FBlockPile.new()
	instance.discard_pile = FBlockPile.new()
	return instance
