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
@onready var input_direction:Vector2
@onready var incnum:float = 0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var touchingwall:bool 
var counteractingforce = 0
var dir:int = 3
var predir

func get_input():
	
	if input_direction.x == (1.0) or (-1.0) :
		oldinpt = input_direction
	
	counteractingforce = counteractingforce - 35
	if counteractingforce < 50:
		counteractingforce = 0
	
	input_direction = Input.get_vector("Left", "Right", "ui_text_backspace", "Jump")
	
	
	
	
	velocity.x = input_direction.x * (speed * incnum) + counteractingforce
	
	if Input.is_action_just_pressed("Jump") and jump == true:
		walljump()
	
	
	if Input.is_action_just_pressed("Jump") and jump == false :
			inum = 0
			velocity.y = jumpv 
			jump = true 

	if not oldinpt == input_direction and jump == false :
		incnum = 0

	velocity.y = velocity.y + inum
	
	if velocity.x > 0.1:
		animated_sprite_2d.flip_h = false
		dir = 1
	if velocity.x < -0.1:
		animated_sprite_2d.flip_h = true
		dir = 0
	if velocity.x != 0:
		animated_sprite_2d.play("Walk_Run")
	else:
		animated_sprite_2d.play("default")

func _physics_process(delta):
	
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
	print(velocity.y)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("ent")
	if jump == true:
		touchingwall = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	print("ext")
	touchingwall = false


func walljump():
	if touchingwall == true:
		if not predir == dir or dir == 3:
			predir = dir 
			inum = 0
			velocity.y = jumpv 
			counteractingforce = -velocity.x * 2 
