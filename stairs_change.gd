extends Node2D
var start_check:bool = false
var player
var transitioning:bool =false
var on_upper_floor = false


func _on_transitioning_stairs_body_entered(body: Node2D) -> void:
	transitioning = true
	on_upper_floor = false
	$"../FloorController".set_player_floor(2)


func _on_up_floor_body_entered(body: Node2D) -> void:
	on_upper_floor = true


func _on_transitioning_stairs_body_exited(body: Node2D) -> void:
	if !on_upper_floor:
		$"../FloorController".set_player_floor(1)
