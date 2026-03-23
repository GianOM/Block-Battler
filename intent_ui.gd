class_name IntentUI
extends HBoxContainer

@onready var intent_icon: TextureRect = $IntentIcon
@onready var intent_value: Label = $IntentValue

func update_intent(intent: Intent):
	if not intent:
		hide()
		return
	intent_icon.texture = intent.icon
	intent_icon.visible = intent_icon.texture != null
	intent_value.text = str(intent.value)
	intent_value.visible = intent.value.length() > 0
	show()
