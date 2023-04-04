extends PlayerState

@export var jump_force: float = 300
@export var walk_speed: float = 100

@export var idle_node: NodePath
@export var walk_node: NodePath
@export var fall_node: NodePath

@onready var idle_state: PlayerState = get_node(idle_node)
@onready var walk_state: PlayerState = get_node(walk_node)
@onready var fall_state: PlayerState = get_node(fall_node)

func enter() -> void:
	player.change_animation(animation_name)
	player.velocity.y = -jump_force

func physics_process(delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("left"):
		move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("right"):
		move = 1
		player.animations.flip_h = false
	
	player.velocity.x = move * walk_speed
	player.velocity.y += player.gravity
	player.move_and_slide()
	
	if player.velocity.y > 0 or Input.is_action_just_released("jump"):
		return fall_state

	if player.is_on_floor():
		if move != 0:
			return walk_state
		return idle_state
	return null
