extends PlayerState

#@export var jump_node: NodePath
#@export var fall_node: NodePath
#@export var walk_node: NodePath
#
#@onready var jump_state: PlayerState = get_node(jump_node)
#@onready var fall_state: PlayerState = get_node(fall_node)
#@onready var walk_state: PlayerState = get_node(walk_node)

@onready var jump_state: PlayerState = $"../Jump"
@onready var fall_state: PlayerState = $"../Fall"
@onready var walk_state: PlayerState = $"../Walk"

func enter() -> void:
	super()
	player.velocity.x = 0

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		return walk_state
	elif Input.is_action_just_pressed("jump"):
		return jump_state
	return null

func physics_process(delta: float) -> BaseState:
	player.velocity.y += player.gravity
	player.move_and_slide()

	if !player.is_on_floor():
		return fall_state
	return null
