extends Camera2D


var speedX = 0
var speedY = 0
var maxSpeed = 20
var speedIncrease = 0.3
var zoomSpeed = 0.01


@export var startX: int
@export var startY: int
@export var startZoom: float
@export var start_font_size: int
var targetX
var targetY
var targetZoom

var vic_label: Label





#func _init():
	#targetX = startX
	#targetY = startY
	#targetZoom = startZoom
	
func _ready() -> void:
	
	vic_label = $Label
	
	vic_label.theme.default_font_size = start_font_size
	targetX = startX
	targetY = startY
	targetZoom = startZoom
	var checkpoints = get_tree().get_nodes_in_group("Checkpoints")
	for cPoint in checkpoints:
		print("Thats one")
		cPoint.move_to.connect(_on_checkpoint_move_to)
	
	var goal = $"../Goal/Area2D"
	if goal != null:
		goal.body_entered.connect(_on_area_2d_body_entered)

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
	
	vic_label.theme.default_font_size = start_font_size / targetZoom


func _on_death_border_body_entered(body):
	targetX = startX
	targetY = startY
	targetZoom = startZoom
	maxSpeed = 80
	speedIncrease = 2.5
	zoomSpeed = 0.01
	
	vic_label.theme.default_font_size = start_font_size


func _on_area_2d_body_entered(body):
	$Label.visible = true
	visible = true
	var timer := Timer.new()
	add_child(timer)
	
	timer.wait_time = 5.0
	timer.one_shot = true
	
	timer.timeout.connect(_on_timer_timeout)
	
	timer.start()
	
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/Level Select.tscn")

