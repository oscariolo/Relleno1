extends Node2D

@export var player:CharacterBody2D
const VANISH_COLOR:Color = Color(1,1,1,.5)
const DEFAULT_COLOR:Color = Color(1,1,1,1)
var tween:Tween
var current_floor:=1
var max_floors:=3


func _ready() -> void:
	max_floors = len($Floors.get_children())

func _process(delta: float) -> void:
	pass


func _on_player_player_occluded(tile: TileMapLayer, occluded:bool) -> void:
	var floors = $Floors.get_children()	
	floors = floors.slice(current_floor)
	for f in floors:
		tween = get_tree().create_tween()
		if occluded:
			tween.tween_property(f,"modulate",VANISH_COLOR,0.5)
		else:
			tween.tween_property(f,"modulate",DEFAULT_COLOR,0.5)
