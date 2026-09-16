extends Camera2D


var speedX = 0
var speedY = 0
var maxSpeed = 20
var speedIncrease = 0.3
var zoomSpeed = 0.01


var startX = 575
var startY = 330
var startZoom = 1
var targetX = 0
var targetY = 0
var targetZoom = 0





func _init():
	targetX = startX
	targetY = startY
	targetZoom = startZoom
	
func _ready() -> void:
	var checkpoints = get_tree().get_nodes_in_group("Checkpoints")
	for cPoint in checkpoints:
		cPoint.move_to.connect(_on_checkpoint_move_to)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# To reset the camera moving faster after the player dies
	if is_equal_approx(position.x, startX):
		maxSpeed = 20
		speedIncrease = 0.3
	if is_equal_approx(zoom.x, startZoom):
		zoomSpeed = 0.01
		
	if (position.x != targetX || position.y != targetY):
		var move = move_toward(position.x, targetX, speedX)
		position.x = move
		if speedX < maxSpeed:
			speedX += speedIncrease
		move = move_toward(position.y, targetY, speedY)
		position.y = move
		if speedY < maxSpeed:
			speedY += speedIncrease
	else:
		speedX = 0
		speedY = 0
		
	if (zoom.x != targetZoom):
		var temp = move_toward(zoom.x, targetZoom, zoomSpeed)
		zoom.x = temp
		zoom.y = temp
	

func _on_checkpoint_move_to(x, y, z):
	targetX = x
	targetY = y
	targetZoom = z


func _on_death_border_body_entered(body):
	targetX = startX
	targetY = startY
	targetZoom = startZoom
	maxSpeed = 80
	speedIncrease = 2.5
	zoomSpeed = 0.01
