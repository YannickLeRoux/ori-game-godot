extends Actor

var shot = preload("res://src/Actors/Shot.tscn")
var insta = preload("res://src/Actors/Insta.tscn")

var can_fire = true
var rate_of_shots = 0.4
var rate_of_insta = 1

export var direction: Vector2 = get_direction()

func fire_shot(direction_x: float):
	print(direction_x)
	var shot_instance = shot.instance()
	shot_instance.position = get_node("shotPosition").get_global_position()
	shot_instance.set_shot_direction(direction_x)
	shot_instance.position.x = shot_instance.position.x if direction_x >= 0.0 else shot_instance.position.x -106
	get_parent().add_child((shot_instance))

func fire_insta(direction_x):
	var insta_instance = insta.instance()
	insta_instance.position = get_node("instaPosition").get_global_position()
	insta_instance.set_insta_direction(direction_x)
	insta_instance.position.x = insta_instance.position.x if direction_x >= 0.0 else insta_instance.position.x -116
	get_parent().add_child((insta_instance))

func _physics_process(delta : float) -> void:
	direction = get_direction()
	get_animation(direction)
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, speed, direction, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return  Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		, -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
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

func get_animation(direction: Vector2) -> void:
	$ori.flip_h = true if direction.x >= 0 else false

	if Input.is_action_pressed("shot"):
		$ori.play("shot")

		if (can_fire == true):
			can_fire = false;
			fire_shot(direction.x)
			yield(get_tree().create_timer(rate_of_shots),"timeout")
			can_fire = true


	elif Input.is_action_pressed("insta"):
		$ori.play("insta")
		if (can_fire == true):
			can_fire = false;
			fire_insta(direction.x)
			yield(get_tree().create_timer(rate_of_insta),"timeout")
			can_fire = true

	elif Input.is_action_pressed("move_right") or  Input.is_action_pressed("move_left"):
		$ori.play("walk")

	elif Input.is_action_pressed("jump"):
		$ori.play("jump")



	else:
		$ori.play("stand")
