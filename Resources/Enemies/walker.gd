extends Enemy

@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@export var speed: float = 200
@export var gravity: int = 8
var readying:bool = true

enum direction {
	RIGHT = 1,
	LEFT = -1
}

@export var starting_direction: direction = direction.RIGHT

@onready var current_direction: direction = starting_direction

func _ready() -> void:
	animations.play("walking")
	if !is_on_floor():
		position.y += 1
	if is_on_floor(): readying = false

func _physics_process(delta: float) -> void:
	if !readying:
		if is_on_wall() or !is_on_floor():
			switch_direction()
		velocity.x = current_direction * speed
	else:
		if is_on_floor(): readying = false
	velocity.y = gravity
	move_and_slide()


func switch_direction() -> void:
	match current_direction:
		direction.RIGHT:
			current_direction = direction.LEFT
		direction.LEFT:
			current_direction = direction.RIGHT
		_:
			current_direction = starting_direction

