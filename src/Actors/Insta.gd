extends RigidBody2D

var projectile_speed = 750

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_impulse(Vector2(),Vector2(projectile_speed, 0))
