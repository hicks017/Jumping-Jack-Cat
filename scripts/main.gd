extends Node2D

@export var pair_scene: PackedScene
@export var spawn_x: float = 600.0
@export var min_y: float = 481.0
@export var max_y: float = 479.0

func _on_timer_timeout() -> void:
	var pair := pair_scene.instantiate() as Node2D
	pair.position = Vector2(spawn_x, randf_range(min_y, max_y))
	pair.scored.connect(_on_pair_scored)
	pair.hit_player.connect(_on_pair_hit_player)
	add_child(pair)


func _on_pair_scored() -> void:
	print("scored")


func _on_pair_hit_player() -> void:
	print("hit")

func _ready() -> void:
	assert(pair_scene != null, "Assign pair_scene in the Inspector")
