class_name Shaker extends RefCounted

var target: Node2D
var start_position: Vector2
var max_shake = 4

func _init(new_target: Node2D) -> void:
	target = new_target
	start_position = target.position
	
func shake(distance: float, duration: float) -> void:
	for i in max_shake:
		target.position = start_position + Vector2(randi_range(-distance, distance), randi_range(-distance, distance))
		await target.get_tree().create_timer(duration / max_shake).timeout
		distance -= distance / max_shake

	target.position = start_position
