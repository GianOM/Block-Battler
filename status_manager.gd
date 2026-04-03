class_name StatusManager
extends GridContainer

signal statuses_applied(type: Status.Type)

const STATUS_UI = preload("res://status_ui.tscn")
const STATUS_APPLICATION_INTERVAL := 0.25

@export var status_owner: Node2D

func apply_statuses_by_type(type: Status.Type):
	if type == Status.Type.CONDITIONAL:
		return #conditional statuses are applied where the condition is met
	var status_queue: Array[Status] = _get_all_statuses().filter(
		func(status: Status):
			return status.type == type
	)
	if status_queue.is_empty():
		#even if it's empty, this signal still needs to be emitted
		#so the combat can continue where this signal was expected to be connected
		statuses_applied.emit(type)
		#print("empty status queue")
		return
	
	var tween:= create_tween()
	for status: Status in status_queue:
		tween.tween_callback(status.apply_status.bind(status_owner))
		tween.tween_interval(STATUS_APPLICATION_INTERVAL)
	tween.finished.connect(func(): statuses_applied.emit(type))


func add_status(status: Status):
	var stackable:= status.stack_type != Status.StackType.NONE
	
	#if it's a new status, add it
	if not _has_status(status.id):
		var new_status_ui: StatusUI = STATUS_UI.instantiate()
		add_child(new_status_ui)
		new_status_ui.status = status
		new_status_ui.status.status_applied.connect(_on_status_applied)
		new_status_ui.status.initialize_status(status_owner)
		return
	
	#if non stackable and can't expire and already have it, TBD -> does nothing
	if not status.can_expire and not stackable:
		return
	
	#if duration based, add more stacks e.g. vulnerable
	if status.can_expire and status.stack_type == Status.StackType.DURATION:
		_get_status(status.id).duration += status.duration
		return
	
	#e.g. strength
	if status.stack_type == Status.StackType.INTENSITY:
		_get_status(status.id).stacks += status.stacks

func _has_status(id: String) -> bool:
	for status_ui: StatusUI in get_children():
		if status_ui.status.id == id:
			return true
	return false

func _get_status(id: String) -> Status:
	for status_ui: StatusUI in get_children():
		if status_ui.status.id == id:
			return status_ui.status 
	return null

func _get_all_statuses() -> Array[Status]:
	var statuses: Array[Status]
	for status_ui: StatusUI in get_children():
		statuses.push_back(status_ui.status)
	return statuses

#when the status does its thing e.g. when the turn where an entity
#is vulnerable ends, reduce the vulnerability duration stack
func _on_status_applied(status: Status):
	if status.can_expire:
		status.duration -= 1
