class_name ObjectPair
extends Node2D

signal scored
signal hit_player

@export var speed := 250.0

@onready var top_placeholder: Area2D = $top_placeholder
@onready var bottom_placeholder: Area2D = $bottom_placeholder
@onready var score_zone: Area2D = $score_zone
@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_placeholder.body_entered.connect(_on_object_body_entered, CONNECT_ONE_SHOT)
	bottom_placeholder.body_entered.connect(_on_object_body_entered, CONNECT_ONE_SHOT)
	score_zone.body_entered.connect(_on_score_body_entered, CONNECT_ONE_SHOT)
	add_to_group("objects")
	notifier.screen_exited.connect(queue_free)

func _on_object_body_entered(_body: Node2D) -> void:
	hit_player.emit()

func _on_score_body_entered(_body: Node2D) -> void:
	scored.emit()

func _physics_process(delta: float) -> void:
	position.x -= speed * delta

func stop() -> void:
	set_physics_process(false)
