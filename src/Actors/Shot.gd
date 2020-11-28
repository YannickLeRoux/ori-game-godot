extends RigidBody2D

var projectile_speed = 750
var _rotation = 0

func set_shot_direction(d: float) -> void: 
	if d == -1:
		_rotation = PI
	else: 
		_rotation = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# var _direction = direction
	apply_impulse(Vector2(),Vector2(projectile_speed, 0).rotated(_rotation))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
