extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis(&"ui_left", &"ui_right")
	
	velocity.x = x_input * 50
	
	move_and_slide()
