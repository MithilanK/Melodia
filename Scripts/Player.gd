extends KinematicBody2D


var speed = 50  # speed in pixels/sec
var velocity = Vector2.ZERO
var ddrection = "down"
var moving = false


var sault = false
var saultclock = 0
var saultFactor = 1

onready var ap = $AnimationPlayer

func get_input():
	velocity = Vector2.ZERO
	
	
	
	if Input.is_action_just_pressed("space"):
		sault = true
	if Input.is_action_pressed('down'):
		velocity.y += 1
		ddrection = "down"
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		ddrection = "up"
	if Input.is_action_pressed('right'):
		velocity.x += 1
		ddrection = "right"
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		ddrection = "left"
	moving = false
	if velocity.x != 0 or velocity.y != 0:
		moving = true
	
	if sault == true:
		if saultclock >= 33:
			saultclock = 0
			sault = false
		else:
			saultclock += 1
		saultFactor = 2.5
	else:
		saultFactor = 1	
	
	velocity = velocity.normalized() * (speed * saultFactor)

func handle_animation():
	if moving:
		if sault:
			if ddrection == "up":
				ap.play("UpRoll")
			if ddrection == "down":
				ap.play("DownRoll")
			if ddrection == "right":
				ap.play("RightSault")
			if ddrection == "left":
				ap.play("LeftSault")
		else:
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
