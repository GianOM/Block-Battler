class_name ModifierValue
extends Node

enum Type {PERCENTAGE, FLAT}

@export var type: Type
@export var percentage_value: float
@export var flat_value: int
@export var id: String

static func create_new_modifier(modifier_id: String, modifier_type: Type) -> ModifierValue:
	var new_modifier:= new()
	new_modifier.id = modifier_id
	new_modifier.type = modifier_type
	return new_modifier
