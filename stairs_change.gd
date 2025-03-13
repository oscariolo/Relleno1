extends Node2D
var start_check:bool = false
var player
var transitioning:bool =false
var on_upper_floor = false


func _on_transitioning_stairs_body_entered(body: Node2D) -> void:
	$"../FloorController".set_player_floor(2)


func _on_transitioning_stairs_body_exited(body: Node2D) -> void:
	if body.velocity.y >= 0:
		$"../FloorController".set_player_floor(1)
	if body.velocity.y < 0:
		$"../FloorController".set_player_floor(2)
