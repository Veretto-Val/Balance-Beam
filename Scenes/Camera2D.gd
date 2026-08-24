extends Camera2D


var speedX = 0
var speedY = 0
var maxSpeed = 10

var startX = 575
var startY = 330
var targetX = 0
var targetY = 0



func _init():
	targetX = startX
	targetY = startY
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (position.x != targetX || position.y != targetY):
		# print("moving!")
		var move = move_toward(position.x, targetX, speedX)
		position.x = move
		if speedX < maxSpeed:
			speedX += 0.3
		move = move_toward(position.y, targetY, speedY)
		position.y = move
		if speedY < maxSpeed:
			speedY += 0.3
	else:
		speedX = 0
		speedY = 0
	

func _on_checkpoint_move_to(x, y, z):
	targetX = x
	targetY = y
	zoom.x = z
	zoom.y = z


func _on_death_border_body_entered(body):
	targetX = startX
	targetY = startY
