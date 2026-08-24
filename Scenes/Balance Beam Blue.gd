extends CharacterBody2D

var strong = false

func _process(delta):
	if Input.is_action_pressed("Strong"):
		strong = true
	else:
		strong = false
	
	if Input.is_action_pressed("Blue Left"):
		if strong:
			rotate(-0.1)
		else:
			rotate(-0.05)
	if Input.is_action_pressed("Blue Right"):
		if strong:
			rotate(0.1)
		else:
			rotate(0.05)
