class_name Hurtbox extends Area2D

@export var is_invincible: bool = false :
	set(value):
		is_invincible = value
		for child in get_children():
			if child is not CollisionObject2D and child is not CollisionObject2D: continue
			child.set_deferred("disabled", is_invincible)

signal hurt(other: Hitbox)

func take_hit(hitbox: Hitbox) -> void:
	if is_invincible: return
	hurt.emit(hitbox)
