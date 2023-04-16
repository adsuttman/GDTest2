extends Area2D
class_name PlayerDetectionField

signal player_entered
signal player_exited


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_entered.emit()



func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_exited.emit()
