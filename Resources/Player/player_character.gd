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

@onready var animations: AnimatedSprite2D = $Animations
@onready var states = $StateManager

var coyote_timer = 0

func _ready() -> void:
	states.init(self)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _process(delta: float) -> void:
	states.process(delta)

func change_animation(animation :String) -> void:
	animations.play(animation)

func handle_collision(object: Object):
	if object.has_meta("name"):
		var name = object.get_meta("name")
		if name == "spikes":
			states.change_state($StateManager/Jump)
