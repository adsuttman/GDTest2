extends CharacterBody2D
class_name Player

@export var gravity: int = 6
@export var walk_speed: float = 400
@export var jump_force: float = 400
@export var air_speed: float = 300
@export var fall_gravity_multiplier: float = 3
@export var coyote_time: int = 5
@export var jump_buffer: int = 5
@export var acceleration: float = walk_speed * 15
@export var fast_fall_multiplier: float = 1.5
@export var terminal_velocity: float = 750
@export var wall_slide_fall_multiplier = 1
var alive = true

@onready var animations: AnimatedSprite2D = $Animations
@onready var states = $StateManager

var coyote_timer = 0

signal player_death()

func _ready() -> void:
	states.init(self)

func _unhandled_input(event: InputEvent) -> void:
	if alive:
		states.input(event)

func _physics_process(delta: float) -> void:
	if alive:
		states.physics_process(delta)

func _process(delta: float) -> void:
	states.process(delta)

func change_animation(animation :String) -> void:
	animations.play(animation)
	
func die() -> void:
	alive = false
	hide()
	player_death.emit()
	process_mode = Node.PROCESS_MODE_DISABLED

func handle_stomp(behavior: String, obj:Object):
	match (behavior):
		"kill":
			die()
		"damage":
			obj.damage(1)


func on_enemy_collision():
	die()

func collect_gem() -> void:
	print("gem collected")
