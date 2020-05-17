extends Actor


func _physics_process(delta : float) -> void:
	get_animation()
	var direction = get_direction()
	var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y < 0.0
	velocity = calculate_move_velocity(velocity, speed, direction, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return  Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0		
	)
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	speed: Vector2,
	direction : Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()

	if direction.y == -1.0: # if jump
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity
	
func get_animation() -> void:
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
		
	elif Input.is_action_pressed("move_right"):
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
		
	elif Input.is_action_pressed("jump"):
		$AnimatedSprite.play("jump")
		
	elif Input.is_action_pressed("shot"):
		$AnimatedSprite.play("shot")
		
	elif Input.is_action_pressed("insta"):
		$AnimatedSprite.play("insta")
		
	else:
		$AnimatedSprite.play("stand")
