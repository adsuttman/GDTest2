extends Control

signal start_pressed()



func _on_start_button_down() -> void:
	start_pressed.emit()
