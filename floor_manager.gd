extends Node2D

@export var player:CharacterBody2D
const VANISH_COLOR:Color = Color(1,1,1,.5)
const DEFAULT_COLOR:Color = Color(1,1,1,1)
const VANISH_SPEED:= 0.5

var tween:Tween
var current_floor:=2
var max_floors:=3


func _ready() -> void:
	max_floors = len($Floors.get_children())
	_disable_player_visibility_detection()

func _process(delta: float) -> void:
	pass


func _on_player_player_occluded(tile: TileMapLayer, occluded:bool) -> void:
	var floors = $Floors.get_children()	
	floors = floors.slice(current_floor)
	for f in floors:
		tween = get_tree().create_tween()
		if occluded:
			tween.tween_property(f,"modulate",VANISH_COLOR,VANISH_SPEED)
		else:
			tween.tween_property(f,"modulate",DEFAULT_COLOR,VANISH_SPEED)

func _disable_player_visibility_detection():
	var floors = $Floors.get_children()
	#the current floor determines which ones in order are to disable detection since higher means the ones at the
	#top are the one that must detect
	floors.resize(current_floor) 
	for f:TileMapLayer in floors:
		


func _on_stairs_transitions_player_up() -> void:
	$Player.set_floor_collision_layer(current_floor,current_floor+1)


func _on_stairs_transitions_player_down() -> void:
	$Player.set_floor_collision_layer(current_floor,current_floor-1)
