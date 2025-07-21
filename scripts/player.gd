extends CharacterBody2D

@export var max_speed = 120
@export var acceleration = 1000
@export var air_acceleration = 2000
@export var friction = 1000
@export var air_friction = 500
@export var up_gravity = 500
@export var down_gravity = 600
@export var jump_amount = 200.0

@onready var animation_player_lower: AnimationPlayer = $AnimationPlayerLower
@onready var animation_player_upper: AnimationPlayer = $AnimationPlayerUpper
@onready var anchor: Node2D = $anchor


func _ready() -> void:
	animation_player_lower.current_animation_changed.connect(func(anim_name: String):
		if animation_player_upper.current_animation == "attack": return
		animation_player_upper.play(anim_name)
	)
	
	animation_player_upper.animation_finished.connect(func(anim_name: String):
		if anim_name != "attack": return
		animation_player_upper.play(animation_player_lower.current_animation)
		animation_player_upper.seek(animation_player_lower.current_animation_position)
	)

func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis(&"move_left", &"move_right")
	
	apply_gravity(delta)

	if x_input != 0:
		accelerate_horz(x_input, delta)
		anchor.scale.x = sign(x_input)
		animation_player_lower.play(&"run")
	else:
		apply_friction(delta)
		animation_player_lower.play(&"stand")
			
	if Input.is_action_just_pressed(&"jump") and is_on_floor():
		velocity.y = -jump_amount
		
	if Input.is_action_just_pressed(&"attack"):
		animation_player_upper.play(&"attack")
	
	if not is_on_floor():
		animation_player_lower.play(&"jump")

	move_and_slide()

func accelerate_horz(direction: float, delta: float) -> void:
	var accel_amount = acceleration
	if not is_on_floor(): accel_amount = air_acceleration 
	
	velocity.x = move_toward(velocity.x, max_speed * direction, accel_amount * delta)

func apply_friction(delta: float) -> void:
	var friction = friction if is_on_floor() else air_friction
	velocity.x = move_toward(velocity.x, 0, friction * delta)

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		if velocity.y <= 0:
			velocity.y += up_gravity * delta
		else:
			velocity.y += down_gravity * delta
