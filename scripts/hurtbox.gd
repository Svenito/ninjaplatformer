class_name Hurtbox extends Area2D

var is_invincible: bool = false

signal hurt(other: Hitbox)

func take_hit(hitbox: Hitbox) -> void:
	if is_invincible: return
	hurt.emit(hitbox)
