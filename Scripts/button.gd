extends Button

@export var level: String

func _ready():
	pressed.connect(_on_pressed)
func _on_pressed() -> void:
	get_tree().change_scene_to_file(level)
