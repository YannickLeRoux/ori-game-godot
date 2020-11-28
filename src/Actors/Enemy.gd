extends "res://src/Actors/Actor.gd"

onready var Shot = preload("res://src/Actors/Shot.gd")

#blinking = false

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	
func _on_ShotDetector_body_entered(body: Node) -> void:
	if body is Shot :
		self.modulate = Color(10,10,10,10)
		yield(get_tree().create_timer(0.1	), "timeout")
		self.modulate = Color(1,1,1,1)
	else: 
		print("insta!")
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall(): 
		_velocity.x *= -1.0
		$girl.flip_h = !$girl.flip_h
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
