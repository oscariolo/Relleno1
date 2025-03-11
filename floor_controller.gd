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
	default()
	player_visibility_area.connect("area_entered",_on_player_visibility_area_entered)
	player_visibility_area.connect("area_exited",_on_player_visibility_area_exited)
	set_player_floor(current_player_floor)
	

func default():
	for f in floors.get_children():
		f.get_child(1).set_collision_layer_value(2,false)

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
	var last_floor = current_player_floor
	current_player_floor = current_floor
	player.z_index = current_player_floor+1
	set_occlussion_area_detections()
	set_floor_collision(last_floor)

func set_occlussion_area_detections():
	var top_floors = get_top_floors()
	var bottom_floors = get_bottom_floors()
	
	for f in top_floors:
		var visibility_detection = f.get_child(0) as Area2D
		visibility_detection.set_collision_layer_value(8,true)
	
	for f in bottom_floors:
		var visibility_detection = f.get_child(0) as Area2D
		visibility_detection.set_collision_layer_value(8,false)

func set_floor_collision(last_floor_pos:=1): #sets the collision accordingly the current one
	#only the floor that the player is currently in must have enabled its collisions
	var last_floor = floors.get_child(last_floor_pos-1)
	var collisions = last_floor.get_child(1) as StaticBody2D
	collisions.set_collision_layer_value(2,false)
	
	print(last_floor_pos)
	var floor_collision = floors.get_child(current_player_floor-1)
	collisions = floor_collision.get_child(1) as StaticBody2D
	collisions.set_collision_layer_value(2,true)
	
