class_name IntentUI
extends HBoxContainer

@onready var intent_icon: TextureRect = $IntentIcon
@onready var intent_value: Label = $IntentValue

func update_intent(intent: Intent, action: EnemyAction, strength: int):
	#print(intent)
	if not intent:
		hide()
		return
	intent_icon.texture = intent.icon
	intent_icon.visible = intent_icon.texture != null
	if action.name == "Defend":
		intent_value.text = intent.value
	elif intent.value.contains(" x "):
		var pre_format = intent.value.split(" x ")
		var final_value = int(pre_format[0]) + strength
		intent_value.text = str(final_value) + " x " + pre_format[-1]
	else:
		intent_value.text = str(int(intent.value) + strength)
	intent_value.visible = intent.value.length() > 0
	show()
