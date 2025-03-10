extends Node2D

@export var player:CharacterBody2D
const VANISH_COLOR:Color = Color(1,1,1,.5)
const DEFAULT_COLOR:Color = Color(1,1,1,1)
var tween:Tween

func _ready() -> void:
	pass


func _on_floor_2_top_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		tween = get_tree().create_tween()
		tween.tween_property($Floor2,"modulate",VANISH_COLOR,0.5)
		


func _on_floor_2_top_detection_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		tween = get_tree().create_tween()
		tween.tween_property($Floor2,"modulate",DEFAULT_COLOR,0.5)
		
