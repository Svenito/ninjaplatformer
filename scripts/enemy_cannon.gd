extends Node2D

const SPARK_PARTICLE_BURST_EFFECT = preload("res://scenes/sparks_particle_burst.tscn")
const IMPACT_PARTICE_BURST_EFFECT = preload("res://scenes/impact_particle_burst_effect.tscn")

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
		var spark_effect = SPARK_PARTICLE_BURST_EFFECT.instantiate()
		get_tree().current_scene.add_child(spark_effect)
		spark_effect.global_position = sprite_2d.global_position
		
		var impact_effect = IMPACT_PARTICE_BURST_EFFECT.instantiate()
		get_tree().current_scene.add_child(impact_effect)
		impact_effect.global_position = sprite_2d.global_position.move_toward(other.global_position, -8)
		impact_effect.rotation = sprite_2d.global_position.direction_to(other.global_position).angle()
		
		effects_animation_player.play(&"hit_flash")
		stats.health -= other.damage
		shaker.shake(2, 0.2)		
	)
	stats.no_health.connect(func(): queue_free())
