extends BaseState
class_name PlayerState

@export var animation_name: String
var player: Player

func enter() -> void:
	player.change_animation(animation_name)

func input(event:InputEvent) -> BaseState:
	return null

func process(delta: float) -> BaseState:
	return null

func physics_process(delta: float) -> BaseState:
	return null
