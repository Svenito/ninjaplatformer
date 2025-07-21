extends CharacterBody2D

@onready var animation_player_lower: AnimationPlayer = $AnimationPlayerLower
@onready var animation_player_upper: AnimationPlayer = $AnimationPlayerUpper


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis(&"ui_left", &"ui_right")	
	velocity.x = x_input * 80

	if x_input == 0:
		animation_player_lower.play(&"stand")
		animation_player_upper.play(&"stand")
	else:
		animation_player_lower.play(&"run")
		animation_player_upper.play(&"run")

	move_and_slide()
