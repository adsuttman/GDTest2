extends PlayerState

#@export var jump_node: NodePath
#@export var fall_node: NodePath
#@export var idle_node: NodePath
#
#@onready var jump_state: PlayerState = get_node(jump_node)
#@onready var fall_state: PlayerState = get_node(fall_node)
#@onready var idle_state: PlayerState = get_node(idle_node)

@onready var idle_state: PlayerState = $"../Idle"
@onready var fall_state: PlayerState = $"../Fall"
@onready var jump_state: PlayerState = $"../Jump"

#func enter() -> void:
#	super()

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	return null

func physics_process(delta: float) -> BaseState:
	if !player.is_on_floor():
		return fall_state

	var move = get_movement_input()
	if move < 0:
		player.animations.flip_h = true
	elif move > 0:
		player.animations.flip_h = false
	
	player.velocity.y += player.gravity
	player.velocity.x = move * player.walk_speed
	player.move_and_slide()
	
	if move == 0:
		return idle_state

	return null

func get_movement_input() -> int:
	if Input.is_action_pressed("left"):
		return -1
	elif Input.is_action_pressed("right"):
		return 1
	return 0
