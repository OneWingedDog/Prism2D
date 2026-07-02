extends CharacterBody2D
@export var speed = 400
var airborne: bool = false
var jumpv = -852
@onready var inum = 0
var inum_max = 50
var jump:bool 
var terminal_velocity:int = 10000

func get_input():
	var input_direction: Vector2 = Input.get_vector("Left", "Right", "ui_text_backspace", "Jump")
	velocity.x = input_direction.x * speed
	if Input.is_action_just_pressed("Jump"):
		inum = 0
		velocity.y = jumpv 
		jump = true 
	if jump == true:
		velocity.y = velocity.y + inum
func _physics_process(delta):
	print(inum)
	inum = inum + 3

	if inum > inum_max:
		inum = inum_max
		
	if velocity.y > terminal_velocity:
		velocity.y = terminal_velocity
	get_input()
	move_and_slide()
