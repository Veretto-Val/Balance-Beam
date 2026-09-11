extends RigidBody2D

var startX = 200
var startY = 200
var reset = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_equal_approx(linear_velocity.x, 0) && 
	is_equal_approx(linear_velocity.y, 0)):
		apply_central_impulse(Vector2(1, 1))
		

func _integrate_forces(state):
	if reset:
		state.transform.origin = Vector2(startX, startY)
		linear_velocity.x = 0
		linear_velocity.y = 0
		reset = false

func _on_death_border_body_entered(body):
	print("YOU DIED DUMBASS")
	reset = true
	
