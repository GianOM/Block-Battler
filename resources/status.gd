class_name Status
extends Resource

signal status_applied(status: Status)
signal status_changed

enum Type {START_OF_TURN, END_OF_TURN, CONDITIONAL}
enum StackType {NONE, INTENSITY, DURATION}

@export var id: String
@export var type: Type
@export var stack_type: StackType
@export var can_expire: bool
@export var duration: int: set = set_duration
@export var stacks: int: set = set_stacks

#temp placeholder
@export var icon: Texture
@export_multiline var tooltip: String

func initialize_status(_target: Node):
	pass

func apply_status(_target: Node):
	status_applied.emit(self)

func get_tooltip():
	return tooltip

func set_duration(new_duration: int):
	duration = new_duration
	status_changed.emit()

func set_stacks(new_stacks: int):
	stacks = new_stacks
	status_changed.emit()
