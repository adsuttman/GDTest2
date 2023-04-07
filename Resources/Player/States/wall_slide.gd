extends PlayerState

@onready var idle_state: PlayerState = $"../Idle"
@onready var walk_state: PlayerState = $"../Walk"
@onready var fall_state: PlayerState = $"../Fall"
@onready var jump_state: PlayerState = $"../Jump"

func physics_process(delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("left"):
		move = -1
		player.animations.flip_h = false
	elif Input.is_action_pressed("right"):
		move = 1
		player.animations.flip_h = true
	player.velocity.x = move * player.air_speed
#	print(player.get_wall_normal())
#	print(player.is_on_wall_only())
	player.velocity.y += player.gravity * player.wall_slide_fall_multiplier
	player.velocity.y = min(player.velocity.y, player.terminal_velocity/2)
	player.move_and_slide()
	
	if player.is_on_wall_only():
		if player.get_wall_normal().x > 0:
			if move == -1:
				pass
			else:
				return fall_state
		else:
			if move == 1:
				pass
			else:
				return fall_state
	else:
		return fall_state
	if player.is_on_floor():
		if move != 0:
			return walk_state
		return idle_state
	return null
