extends Control

@onready var penguin : AnimatedSprite2D = $Penguin
@onready var button : Button = $PlayButton

func play() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _ready() -> void:
	penguin.play("idle")
	button.pressed.connect(play)
	button.grab_focus()
