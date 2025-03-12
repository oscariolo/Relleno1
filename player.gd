extends CharacterBody2D
const SPEED = 3500
const JUMP_VELOCITY = -400.0
var direction:Vector2

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = SPEED*direction*delta
	
	sprite_manager()
	move_and_slide()

func sprite_manager():
	if direction.length() == 0: #no input
		$AnimatedSprite2D.set_frame(1)
		$AnimatedSprite2D.pause()
	else:
		var angle = int(direction.angle()*180/PI*-1)
		match angle:
			0:$AnimatedSprite2D.play("right")
			90:$AnimatedSprite2D.play("up")
			-180:$AnimatedSprite2D.play("left")
			135:$AnimatedSprite2D.play("up_left")
			45:$AnimatedSprite2D.play("up_right")
			-90:$AnimatedSprite2D.play("down")
			-135:$AnimatedSprite2D.play("down_left")
			-45:$AnimatedSprite2D.play("down_right")
			
