extends RigidBody2D

var can_score = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is CharacterBody2D and body.is_on_floor():
		queue_free()
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("hoop"):
		can_score = true
	pass # Replace with function body.
