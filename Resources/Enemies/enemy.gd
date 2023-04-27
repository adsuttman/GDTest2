extends CharacterBody2D

class_name Enemy

@export var health = 1
var alive = true

signal died

func _physics_process(delta: float) -> void:
	if alive:
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var obj = collision.get_collider()
			if obj.is_in_group("player"):
				obj.on_enemy_collision()

func die():
	alive = false
	died.emit()
	queue_free()

func damage(amount: int):
	health -= amount
	if health <= 0:
		die()
