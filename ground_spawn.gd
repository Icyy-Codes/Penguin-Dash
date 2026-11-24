extends Node2D

@export var chunk_s : PackedScene
@export var player : Node2D
@export var spawn_front = 4000
@export var del_back = 2000

var next = 0

func spawn_chunk() -> void:
	
	var chunk : Node2D = chunk_s.instantiate()
	add_child(chunk)
	chunk.global_position = Vector2(next,global_position.y)
	next = chunk.get_node("End").global_position.x

func _ready() -> void:
	next = global_position.x
	spawn_chunk()
	
func _process(delta: float) -> void:
	while player.global_position.x+spawn_front>next:
		spawn_chunk()
		
	var old = get_child(0)
	
	if get_child_count()>1 and old.get_node("End").global_position.x < player.global_position.x - del_back:
		old.queue_free()
