class_name StrengthStatus
extends Status

func apply_status(target: Node):
	
	status_applied.emit(self)
