class_name RewardButton
extends Button

@export var reward_icon: Texture: set = set_reward_icon
@export var reward_text: String: set = set_reward_text

@onready var button_icon: TextureRect = %ButtonIcon
@onready var button_text: Label = %ButtonText


func set_reward_icon(new_icon: Texture):
	reward_icon = new_icon
	if not is_node_ready():
		await ready
	button_icon.texture = reward_icon

func set_reward_text(new_text: String):
	reward_text = new_text
	if not is_node_ready():
		await ready
	button_text.text = reward_text

func _on_pressed():
	queue_free()
