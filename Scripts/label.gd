extends Label


func _on_area_2d_body_entered(body: Node2D) -> void:
	visible = true
	var timer := Timer.new()
	add_child(timer)
	
	timer.wait_time = 5.0
	timer.one_shot = true
	
	timer.timeout.connect(_on_timer_timeout)
	
	timer.start()
	
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/Level Select.tscn")
