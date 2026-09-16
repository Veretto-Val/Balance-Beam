extends Area2D

@export var x: float
@export var y: float
@export var zoom: float

signal move_to(x, y, zoom)

func _init() -> void:
	add_to_group("Checkpoints")


func _on_body_entered(body):
	move_to.emit(x, y, zoom)
