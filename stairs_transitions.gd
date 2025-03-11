extends Node2D
var going_up = true
var going_down = false

signal player_up
signal player_down


func _on_stair_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		#check if it took stairs up or down, on area of stairs its on the next floor
		#if when entered stair area its on top then keep the layer
		if body.global_position.y <= $StairArea/UpperStep.global_position.y: #top area nothing changes
			print("going down")
			return

func _on_stair_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.global_position.y >= $StairArea/LowerStep.global_position.y: #went down
			player_down.emit()
		
		if body.global_position.y < $StairArea/LowerStep.global_position.y: #went up
			player_up.emit()
			
