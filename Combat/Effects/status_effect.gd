class_name StatusEffect
extends Effect

var status: Status

func execute(target: Node):
	if not target:
		#debug
		print("no target found for status effect")
		return
	if target is Enemy or target is Player:
		target.status_manager.add_status(status)
