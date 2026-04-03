class_name VulnerableStatus
extends Status

const MODIFIER:= 0.5


func apply_status(target: Node):
	print("%s took %s%% more damage" % [target, MODIFIER * 100])
	
	#debugging - this is how DoT would work
	#var damage_effect:= Damage.new()
	#damage_effect.amount = 10
	#damage_effect.execute(target)
	
	status_applied.emit(self)
