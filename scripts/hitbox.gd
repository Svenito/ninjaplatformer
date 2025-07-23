class_name Hitbox extends Area2D

@export var damage = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	assert(area is Hurtbox, "Hitbox: area is not a Hurtbox")
	var hurtbox = area as Hurtbox
	hurtbox.take_hit(self)
