extends CharacterBody2D

var flipped = false
var goSlow = false
var goFast = false

var speed = 0
var targetRadians
var startRadians

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func _ready():
	startRadians = rotation
	targetRadians = rotation + 1

func _process(delta):
	if is_equal_approx(rotation, targetRadians):
		flipped = true
		goFast = false
		goSlow = false
	elif is_equal_approx(rotation, startRadians):
		flipped = false
	
	if ((Input.is_action_pressed("Red Left") or Input.is_action_pressed("Red Right"))
	and (!goFast and !goSlow)):
		if Input.is_action_pressed("Strong"):
			goFast = true
			speed = 0.1
		else:
			goSlow = true
			speed = 0.05
		flipped = false
	
	if goSlow or goFast:
		rotation = move_toward(rotation, targetRadians, speed)
	
	if flipped:
		rotation = move_toward(rotation, startRadians, 0.03)
