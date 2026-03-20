class_name Damage
extends Effect

var amount:= 0

#see effect.gd
#func execute(targets: Array[Node]):
	#for target in targets:
		#if not target:
			#continue
		#if target is Enemy or target is Player:
			#target.take_damage(amount)

func execute(target: Node):
	target.take_damage(amount)
