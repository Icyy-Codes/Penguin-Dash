extends CanvasLayer

@export var player : Node2D
@export var dy = 800
@onready var button1 : Button = $PlayAgain
@onready var button2 : Button = $MainMenu

func play1() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func play2() -> void:
	get_tree().change_scene_to_file("res://Main_Menu.tscn")

func _ready() -> void:
	hide()
	button1.pressed.connect(play1)
	button2.pressed.connect(play2)
	
func _process(delta: float) -> void:
	if player.global_position.y > dy:
		show()
