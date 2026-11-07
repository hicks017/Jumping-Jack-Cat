extends CharacterBody2D

@export var jump_velocity := -550.0
@export var gravity := 1400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

	move_and_slide()
	_update_animation()

func _update_animation() -> void:
	if velocity.y >= -100.0:
		$AnimatedSprite2D.play("down")
	else:
		$AnimatedSprite2D.play("up")
