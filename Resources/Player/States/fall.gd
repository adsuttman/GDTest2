extends PlayerState

#@export var idle_node: NodePath
#@export var walk_node: NodePath
#
#@onready var idle_state: PlayerState = get_node(idle_node)
#@onready var walk_state: PlayerState = get_node(walk_node)

@onready var idle_state: PlayerState = $"../Idle"
@onready var walk_state: PlayerState = $"../Walk"
@onready var jump_state: PlayerState = $"../Jump"
@onready var wall_slide_state: PlayerState = $"../WallSlide"

var jump_timer: int = 0

#func enter() -> void:
#	player.change_animation(animation_name)

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		if player.coyote_timer > 0:
			player.coyote_timer = 0
			return jump_state
		else:
			jump_timer = player.jump_buffer
	return null

func physics_process(delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("left"):
		move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("right"):
		move = 1
		player.animations.flip_h = false
	if Input.is_action_pressed("down"):
		player.velocity.y += player.gravity * player.fall_gravity_multiplier\
		* player.fast_fall_multiplier
	else:
		player.velocity.y += player.gravity * player.fall_gravity_multiplier
	player.velocity.y = min(player.velocity.y, player.terminal_velocity)
#	print(player.velocity.y)
	player.velocity.x = move * player.air_speed
	player.move_and_slide()
	
	if player.coyote_timer > 0:
		player.coyote_timer -= 1
#		print(player.coyote_timer)
	if jump_timer > 0:
		jump_timer -= 1
#		print(jump_timer)
	if player.is_on_wall_only():
		if player.get_wall_normal().x == -move:
			return wall_slide_state
	if player.is_on_floor():
		var object = player.get_slide_collision(0).get_collider()
		var stomp_behavior = object.get_meta("stomp_behavior")
		if(stomp_behavior):
			player.handle_stomp(stomp_behavior, object)
		if jump_timer > 0:
			jump_timer = 0
#			print("jump buffer activated")
			return jump_state
		elif move != 0:
			return walk_state
		else:
			return idle_state
	return null

func exit() -> void:
	jump_timer = 0
	player.coyote_timer = 0
