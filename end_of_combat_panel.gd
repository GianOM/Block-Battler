class_name EndOfCombatPanel
extends Panel

enum Type {WIN, LOSE}

@onready var label: Label = %Label
@onready var continue_button: Button = %ContinueButton
@onready var restart_button: Button = %RestartButton

func _ready() -> void:
	continue_button.pressed.connect(func(): COMBATE.combat_won.emit())
	restart_button.pressed.connect(get_tree().reload_current_scene)
	COMBATE.end_of_combat_screen_requested.connect(show_screen)

func show_screen(text: String, type: Type):
	label.text = text
	continue_button.visible = type == Type.WIN
	restart_button.visible = type == Type.LOSE
	show()
	get_tree().paused = true
