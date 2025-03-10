extends CharacterBody2D


const SPEED = 3500
const JUMP_VELOCITY = -400.0
signal player_occluded(tile:TileMapLayer,occluded:bool)
var current_floor = 1


func _physics_process(delta: float) -> void:

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = SPEED*direction*delta

	move_and_slide()


func _on_view_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Floor"):
		player_occluded.emit(body,true)


func _on_view_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Floor"):
		player_occluded.emit(body,false)
