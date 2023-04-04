extends Node
class_name BaseState

func enter() -> void:
	pass

func exit() -> void:
	pass

func input(event:InputEvent) -> BaseState:
	return null

func process(delta: float) -> BaseState:
	return null

func physics_process(delta: float) -> BaseState:
	return null
