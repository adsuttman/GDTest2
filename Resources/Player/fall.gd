extends PlayerState

@export var walk_speed: float = 100

@export var idle_node: NodePath
@export var walk_node: NodePath

@onready var idle_state: PlayerState = get_node(idle_node)
@onready var walk_state: PlayerState = get_node(walk_node)

func enter() -> void:
	player.change_animation(animation_name)

func physics_process(delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("left"):
		move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("right"):
		move = 1
		player.animations.flip_h = false
	
	player.velocity.x = move * walk_speed
	player.velocity.y += player.gravity * 3
	player.move_and_slide()

	if player.is_on_floor():
		if move != 0:
			return walk_state
		else:
			return idle_state
	return null
