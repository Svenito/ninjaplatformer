extends Node2D

@export var stats: Stats :
	set(value):
		stats = value
		if value is not Stats: return
		stats = stats.duplicate()

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var effects_animation_player: AnimationPlayer = $EffectsAnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var shaker = Shaker.new(sprite_2d)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurtbox.hurt.connect(func(other: Hitbox):
		effects_animation_player.play(&"hit_flash")
		stats.health -= other.damage
		shaker.shake(2, 0.2)
	)
	stats.no_health.connect(func(): queue_free())
