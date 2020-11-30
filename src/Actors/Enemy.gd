extends "res://src/Actors/Actor.gd"

onready var Shot = preload("res://src/Actors/Shot.gd")
onready var Insta = preload("res://src/Actors/Insta.gd")

#blinking = false
var life = 3

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	
func _on_ShotDetector_body_entered(body: Node) -> void:
	if self.life <= 0:
		var anim = $AnimationPlayer.get_animation("flash")
		anim.set_loop(true)
		$AnimationPlayer.play("flash")
		if body is Insta:
			queue_free()
	
	# if body.get_name() == "Shot"
	if body is Shot :
		self.life-=1
		$AnimationPlayer.play("flash")
			
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall(): 
		_velocity.x *= -1.0
		$girl.flip_h = !$girl.flip_h
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
		

	
func _flash()-> void:
	self.modulate = Color(10,10,10,10)
	yield(get_tree().create_timer(0.05	), "timeout")
	self.modulate = Color(1,1,1,1)
	yield(get_tree().create_timer(0.05	), "timeout")
