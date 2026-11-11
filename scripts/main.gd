extends Node2D

@export var pair_scene: PackedScene
@export var spawn_x: float = 600.0
@export var min_y: float = 190.0
@export var max_y: float = 770.0

@onready var score_label: Label = %ScoreLabel
@onready var timer: Timer = %Timer
@onready var cat: Cat = %cat
@onready var game_over_ui: Control = %GameOverUI
@onready var restart_button: Button = %RestartButton

var score := 0
var game_over := false


func _ready() -> void:
	score_label.text = str(score)
	restart_button.pressed.connect(_on_restart_pressed)


func _on_timer_timeout() -> void:
	var pair := pair_scene.instantiate() as ObjectPair
	pair.position = Vector2(spawn_x, randf_range(min_y, max_y))
	pair.scored.connect(_on_pair_scored)
	pair.hit_player.connect(_on_pair_hit_player)
	add_child(pair)


func _on_pair_scored() -> void:
	if game_over:
		return
	score += 1
	score_label.text = str(score)


func _on_pair_hit_player() -> void:
	if game_over:
		return
	game_over = true
	game_over_ui.visible = true
	timer.stop()
	get_tree().call_group("objects", "stop")
	cat.die()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
