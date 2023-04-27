extends Node

@export var TestLevel: PackedScene = preload("res://Resources/Levels/test_level.tscn")
@onready var MainMenu = get_tree().get_first_node_in_group("mainmenu")
var current_level
@onready var game: Node = get_node("/root/Game")

func _ready() -> void:
	MainMenu.start_pressed.connect(load_level)
	
func load_level() -> void:
	current_level = TestLevel.instantiate()
	game.add_child(current_level)
	MainMenu.hide()
	for player in get_tree().get_nodes_in_group("player"):
		player.player_death.connect(on_player_death)
	
func reload() -> void:
	current_level.queue_free()
	load_level()

func on_player_death():
	await get_tree().create_timer(1).timeout
	reload()
