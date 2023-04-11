extends Node

@export var TestLevel: PackedScene = preload("res://Resources/Levels/test_level.tscn")
@onready var MainMenu = get_tree().get_first_node_in_group("mainmenu")

func _ready() -> void:
	MainMenu.start_pressed.connect(load_level)
	
func load_level() -> void:
	var inst = TestLevel.instantiate()
	get_tree().root.add_child(inst)
	MainMenu.hide()
