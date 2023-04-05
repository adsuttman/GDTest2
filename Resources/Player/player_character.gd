extends CharacterBody2D
class_name Player

@export var gravity: int = 6
@export var walk_speed: float = 200
@export var jump_force: float = 300
@export var air_speed: float = 100
@export var fall_gravity_multiplier: float = 3
@export var coyote_time: int = 5
@export var jump_buffer: int = 5

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
