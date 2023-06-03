extends KinematicBody2D


var speed = 50  # speed in pixels/sec
var velocity = Vector2.ZERO
var ddrection = "down"
var moving = false

onready var ap = $AnimationPlayer

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		ddrection = "right"
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		ddrection = "left"
	if Input.is_action_pressed('down'):
		velocity.y += 1
		ddrection = "down"
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		ddrection = "up"
	moving = false
	if velocity.x != 0 or velocity.y != 0:
		moving = true
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

func handle_animation():
	if moving:
		if ddrection == "up":
			ap.play("Up")
		if ddrection == "down":
			ap.play("Down")
		if ddrection == "right":
			ap.play("Right")
		if ddrection == "left":
			ap.play("Left")
	else:
		if ddrection == "up":
			ap.play("UpIdle")
		if ddrection == "down":
			ap.play("DownIdle")
		if ddrection == "right":
			ap.play("RightIdle")
		if ddrection == "left":
			ap.play("LeftIdle")
func _physics_process(delta):
	get_input()
	handle_animation()
	velocity = move_and_slide(velocity)
