class_name EntityStats
extends Resource

signal changes_in_stats

@export_category("Basic Stats")
@export var max_hp: int


@export_category("Visual Parameters")
@export var image: Texture

var hp: int: set = set_hp
var shield: int: set = set_shield

func set_hp(value: int):
	hp = clampi(value, 0, max_hp)
	changes_in_stats.emit()
	
func set_shield(value: int):
	shield = clampi(value, 0, 999)
	changes_in_stats.emit()

func take_damage(damage: int):
	if damage <= 0:
		return
		
	var damage_after_shield = clampi(damage - shield, 0, 9999999)
	
	self.shield = clampi(shield - damage, 0, 9999999) # v
	self.hp -= damage_after_shield
	#if shield is bigger than dmg, dmg taken would be negative, so... no, it has to be minimum 0

## this is so that when there are multiple of the same enemy type, 
## they are considered different enetities and won't share stat updates. 
## e.g.(when one entity takes dmg, other entities of the same type would also take dmg
func create_instance() -> Resource: 
	
	#WARNING: O PLAYER NAO TEM SHIELD INICIAL
	
	var instance: EntityStats = self.duplicate()
	instance.hp = max_hp
	instance.shield = 0
	return instance
