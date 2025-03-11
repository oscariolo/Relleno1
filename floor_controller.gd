extends Node
@export var player:CharacterBody2D
@export var player_visibility_area:Area2D
@export var floors:Node2D
@export var current_player_floor = 1
var floors_covering_view = 0
var tween:Tween
const VANISH_COLOR:Color = Color(1,1,1,.5)
const DEFAULT_COLOR:Color = Color(1,1,1,1)
const VANISH_SPEED:= 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_visibility_area.connect("area_entered",_on_player_visibility_area_entered)
	player_visibility_area.connect("area_exited",_on_player_visibility_area_exited)
	set_occlussion_area_detections()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_visibility_area_entered(area:Area2D):
	floors_covering_view +=1
	_occlude_top_floors(true)

func _on_player_visibility_area_exited(area:Area2D):
	floors_covering_view -=1
	if floors_covering_view == 0:
		_occlude_top_floors(false)
	if floors_covering_view < 0:
		printerr("Error, collisions less than detected????")


func _occlude_top_floors(occluded:bool):
	var top_floors = get_top_floors()
	for f in top_floors:
		tween = get_tree().create_tween()
		if occluded:
			tween.tween_property(f,"modulate",VANISH_COLOR,VANISH_SPEED)
		else:
			tween.tween_property(f,"modulate",DEFAULT_COLOR,VANISH_SPEED)

func get_top_floors()->Array:
	var floors_list = floors.get_children()
	return floors_list.slice(current_player_floor)

func get_bottom_floors()->Array:
	var floors_list = floors.get_children()
	floors_list.resize(current_player_floor)
	return floors_list

func set_player_floor(current_floor:int):
	current_player_floor = current_floor
	set_occlussion_area_detections() 

func set_occlussion_area_detections():
	var top_floors = get_top_floors()
	var bottom_floors = get_bottom_floors()
	
	for f:TileMapLayer in top_floors:
		var visibility_detection = f.get_child(0) as Area2D
		visibility_detection.set_collision_layer_value(8,true)
	
	for f:TileMapLayer in bottom_floors:
		var visibility_detection = f.get_child(0) as Area2D
		visibility_detection.set_collision_layer_value(8,false)
