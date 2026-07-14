# To anyone who is file ripping the game (I would be surprised if this 
# got even a remotley small community)
# This code is super unoptimised 
# I barley even know how it works myself
# you WILL need to read through all of the code multiple times 
# to figure out what most of the variables mean
# -Idkxname

extends CharacterBody2D
var speedmax = 800
@onready var speed = 800
var airborne: bool = false
var jumpv = -900
@onready var inum = 0
var inum_max = 50
var jump:bool 
var terminal_velocity:int = 10000
@onready var oldinpt
@onready var input_direction:Vector2
@onready var incnum:float = 0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var touchingwall:bool 
var counteractingforce = 0
var dir:int = 3
var predir
var is_right:bool = false
var is_left:bool = false

func get_input():
	
	if input_direction.x == (1.0) or (-1.0) :
		oldinpt = input_direction
	
	#counteractingforce = counteractingforce 
	#if counteractingforce < 50:
	#	counteractingforce = 0
	
	input_direction = Input.get_vector("Left", "Right", "ui_text_backspace", "Jump")
	
	
	
	
	velocity.x = input_direction.x * (speed * incnum) + counteractingforce
	
	
	if Input.is_action_just_pressed("Right"):
		is_right = true
	
	if Input.is_action_just_released("Right"):
		is_right = false
	
	if Input.is_action_just_pressed("Left"):
		is_left = true
	
	if Input.is_action_just_released("Left"):
		is_left = false
	
	
	
	
	
	
	if Input.is_action_just_pressed("Jump") and jump == true:
		walljump()
	
	
	if Input.is_action_just_pressed("Jump") and jump == false :
			inum = 0
			velocity.y = jumpv 
			jump = true 

	if not oldinpt == input_direction and jump == false :
		incnum = 0

	velocity.y = velocity.y + inum
	
	# Running and Flipping
	if velocity.x > 0.1:
		animated_sprite_2d.flip_h = false
		dir = 1
	if velocity.x < -0.1:
		animated_sprite_2d.flip_h = true
		dir = 0
	if velocity.x != 0:
		animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("default")
	# Jumping animation
	if jump:
		animated_sprite_2d.play("Jump")
		
func _physics_process(delta):
	
	print(counteractingforce)
	print(velocity.x)
	
	if counteractingforce < 0 :
		counteractingforce = counteractingforce + 100

	if counteractingforce > 0 :
		counteractingforce = counteractingforce - 100


	
	if touchingwall == true:
		if velocity.y > 0:
			inum = inum/2
	
	if not incnum > 0.9:
		incnum = incnum + 0.025
	else:
		incnum = 1
	
	if velocity.y == 0:
		predir = 3
		dir = 3
		jump = false
		touchingwall = false
	
	
	inum = inum + 3
	
	if position.y > 12000:
		global_position = Vector2(0,0)
	if inum > inum_max:
		inum = inum_max
	
	if velocity.y > terminal_velocity:
		velocity.y = terminal_velocity
		

		
	get_input()
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if jump == true:
		touchingwall = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	touchingwall = false


func walljump():
	if touchingwall == true:
		if not predir == dir or dir == 3:
			predir = dir 
			inum = 0
			velocity.y = jumpv 
			if dir == 1:
				if is_right == true:
					counteractingforce = -1600
				else:
					counteractingforce = -800
			if dir == 0:
				if is_left == true:
					counteractingforce = 1600
				else:
					counteractingforce = 800
