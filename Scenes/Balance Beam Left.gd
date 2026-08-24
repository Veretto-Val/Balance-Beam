extends StaticBody2D

func _process(delta):
	if Input.is_action_pressed("Blue Left"):
		rotation_degrees -= 2;
	if Input.is_action_pressed("Blue Right"):
		rotation_degrees += 2;
