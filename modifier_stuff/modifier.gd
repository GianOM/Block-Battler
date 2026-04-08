class_name Modifier
extends Node

enum Type {DMG_DEALT, DMG_TAKEN, NO_MODIFIER}

@export var type: Type

func get_value(id: String) -> ModifierValue:
	for value: ModifierValue in get_children():
		if value.id == id:
			return value
	return null

func add_new_value(value: ModifierValue):
	var modifier_value:= get_value(value.id)
	if not modifier_value:
		add_child(value)
	else:
		modifier_value.flat_value = value.flat_value
		modifier_value.percentage_value = value.percentage_value

func remove_value(id: String):
	for value: ModifierValue in get_children():
		if value.id == id:
			value.queue_free()

func clear_values():
	for value: ModifierValue in get_children():
		value.queue_free()

func get_modified_value(base_value: int) -> int:
	var flat_result:= base_value
	var percentage_result:= 1.0
	
	#apply flat first, then percentage
	for value: ModifierValue in get_children():
		if value.type == ModifierValue.Type.FLAT:
			flat_result += value.flat_value
	for value: ModifierValue in get_children():
		if value.type == ModifierValue.Type.PERCENTAGE:
			percentage_result += value.percentage_value
	
	return floori(flat_result * percentage_result)
