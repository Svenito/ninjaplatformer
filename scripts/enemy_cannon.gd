extends Node2D

@export var stats: Stats :
	set(value):
		stats = value
		if value is not Stats: return
		stats = stats.duplicate()

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var effects_animation_player: AnimationPlayer = $EffectsAnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurtbox.hurt.connect(func(other: Hitbox):
		effects_animation_player.play(&"hit_flash")
		stats.health -= other.damage
	)
	stats.no_health.connect(func(): queue_free())
