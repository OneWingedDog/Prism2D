extends CharacterBody2D
var speedmax = 800
@onready var speed = 800
var airborne: bool = false
var jumpv = -852
@onready var inum = 0
var inum_max = 50
var jump:bool 
var terminal_velocity:int = 10000
@onready var oldinpt
@onready var input_direction: Vector2 
@onready var incnum:float = 0

func get_input():
	
	oldinpt = input_direction
	
	
	
	input_direction = Input.get_vector("Left", "Right", "ui_text_backspace", "Jump")
	velocity.x = input_direction.x * (speed * incnum)
	
	if not oldinpt == input_direction:
		incnum = 0
	
	
	if Input.is_action_just_pressed("Jump") and jump == false:
		inum = 0
		velocity.y = jumpv 
		jump = true 

	velocity.y = velocity.y + inum

func _physics_process(delta):
	
	if not incnum > 0.9:
		incnum = incnum + 0.025
	else:
		incnum = 1
	
	if velocity.y == 0:
		jump = false

	

	inum = inum + 3

	if position.y > 12000:
		global_position = Vector2(0,0)
	if inum > inum_max:
		inum = inum_max

	if velocity.y > terminal_velocity:
		velocity.y = terminal_velocity
	get_input()
	move_and_slide()
