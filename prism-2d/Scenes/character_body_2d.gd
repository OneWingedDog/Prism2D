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
@onready var touchingwall:bool 

func get_input():
	
	if input_direction.x == (1.0) or (-1.0) :
		oldinpt = input_direction
	

	
	input_direction = Input.get_vector("Left", "Right", "ui_text_backspace", "Jump")
	
	
	
	
	velocity.x = input_direction.x * (speed * incnum)
	
	if Input.is_action_just_pressed("Jump") and jump == true:
		walljump()
	
	
	if Input.is_action_just_pressed("Jump") and jump == false:
		inum = 0
		velocity.y = jumpv 
		jump = true 

	if not oldinpt == input_direction and jump == false :
		incnum = 0

	velocity.y = velocity.y + inum
	
	if velocity.x > 0.1:
		animated_sprite_2d.flip_h = false
	if velocity.x < -0.1:
		animated_sprite_2d.flip_h = true
	if velocity.x != 0:
		animated_sprite_2d.play("Walk_Run")
	else:
		animated_sprite_2d.play("default")

func _physics_process(delta):
	
	if not incnum > 0.9:
		incnum = incnum + 0.025
	else:
		incnum = 1
	
	if velocity.y == 0:
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
	print(touchingwall)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("ent")
	if jump == true:
		touchingwall = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	print("ext")
	touchingwall = false


func walljump():
	if touchingwall == true:
		inum = 0
		velocity.y = jumpv 
