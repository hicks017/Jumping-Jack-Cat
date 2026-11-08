extends Node2D

@export var pair_scene: PackedScene
@export var spawn_x: float = 600.0
@export var min_y: float = 190.0
@export var max_y: float = 770.0

@onready var score_label: Label = %ScoreLabel

var score := 0


func _ready() -> void:
	score_label.text = str(score)
	assert(pair_scene != null, "Assign pair_scene in the Inspector")


func _on_timer_timeout() -> void:
	var pair := pair_scene.instantiate() as ObjectPair
	pair.position = Vector2(spawn_x, randf_range(min_y, max_y))
	pair.scored.connect(_on_pair_scored)
	pair.hit_player.connect(_on_pair_hit_player)
	add_child(pair)


func _on_pair_scored() -> void:
	score += 1
	score_label.text = str(score)


func _on_pair_hit_player() -> void:
	print("hit")
