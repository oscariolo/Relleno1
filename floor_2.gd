extends TileMapLayer
var tween
const VANISH_COLOR = Color(1,1,1,0.5)
const DEFAULT_COLOR = Color(1,1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visibility_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		tween = get_tree().create_tween()
		tween.tween_property(self,"modulate",VANISH_COLOR,0.7)


func _on_visibility_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		tween = get_tree().create_tween()
		tween.tween_property(self,"modulate",DEFAULT_COLOR,0.7)
