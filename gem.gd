extends Node2D

func _on_player_detection_field_player_entered(player) -> void:
	player.collect_gem()
	queue_free()
