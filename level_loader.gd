extends Node

@export var TestLevel: PackedScene = preload("res://Resources/Levels/test_level.tscn")
@onready var MainMenu = get_tree().get_first_node_in_group("mainmenu")
var current_level

func _ready() -> void:
	MainMenu.start_pressed.connect(load_level)
	
func load_level() -> void:
	current_level = TestLevel.instantiate()
	get_tree().root.add_child(current_level)
	MainMenu.hide()
	
func reload() -> void:
	current_level.queue_free()
	current_level = TestLevel.instantiate()
	get_tree().root.add_child(current_level)
	
