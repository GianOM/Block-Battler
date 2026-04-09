extends FBlock_Data

var base_dmg:= 5

func do_fblock_actions(target: Node):
	var damage:= Damage.new()
	#TODO apply modifiers to base dmg
	damage.amount = base_dmg
	damage.execute(target)
