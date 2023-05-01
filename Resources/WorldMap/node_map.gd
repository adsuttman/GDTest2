extends Node2D

@export var start_node: MapNode
@export var navigation_speed: int = 150
@export var navigator: Node2D

@onready var current_map_node: MapNode = start_node
var navigating: bool = false
var target_node: MapNode
var navigation_path = PathFollow2D
@onready var navigator_scale = navigator.scale

enum direction {
	up,
	right,
	down,
	left
}

func _process(delta: float) -> void:
	if !navigating:
		if Input.is_action_pressed("ui_up"):
			if current_map_node.up: start_navigation(direction.up)
		if Input.is_action_pressed("ui_right"):
			if current_map_node.right: start_navigation(direction.right)
		if Input.is_action_pressed("ui_down"):
			if current_map_node.down: start_navigation(direction.down)
		if Input.is_action_pressed("ui_left"):
			if current_map_node.left: start_navigation(direction.left)
	else:
			navigation_path.progress += navigation_speed * delta
			print(navigation_path.progress)
			if navigation_path.progress_ratio == 1.0:
				end_navigation()
			pass

func start_navigation(dir: direction):
	match dir:
		direction.up:
			target_node = current_map_node.up
			new_path()
			current_map_node.up_path.add_child(navigation_path)
			add_navigator_to_path()
		direction.right:
			target_node = current_map_node.right
			new_path()
			current_map_node.right_path.add_child(navigation_path)
			add_navigator_to_path()
		direction.down:
			target_node = current_map_node.down
			new_path()
			current_map_node.down_path.add_child(navigation_path)
			add_navigator_to_path()
		direction.left:
			target_node = current_map_node.left
			new_path()
			current_map_node.left_path.add_child(navigation_path)
			add_navigator_to_path()
	navigating = true

func new_path():
			navigation_path = PathFollow2D.new()
			navigation_path.set_loop(false)
			navigation_path.rotates = false

func add_navigator_to_path():
			navigator.reparent(navigation_path)
			navigator.transform.x = current_map_node.transform.x
			navigator.transform.y = current_map_node.transform.y
			navigator.scale = navigator_scale

func end_navigation():
	navigating = false
	navigator.reparent(self)
	current_map_node = target_node
	target_node = null
	navigation_path = null
