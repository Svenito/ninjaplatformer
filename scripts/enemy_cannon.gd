extends Node2D
@onready var hurtbox: Hurtbox = $Hurtbox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurtbox.hurt.connect(func(other: Hitbox):
		queue_free()
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
