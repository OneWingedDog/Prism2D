extends CharacterBody2D
@export var speed = 400
var airborne: bool = false

func get_input():
	var input_direction: Vector2 = Input.get_vector("Left", "Right", "ui_text_backspace", "Jump")
	velocity.x = input_direction.x * speed
	print(input_direction)
	if Input.is_action_just_pressed("Jump"):
		velocity.y = -200
	if not Input.is_action_pressed("Jump"):
		velocity.y = 0
	
func _physics_process(delta):
	get_input()
	move_and_slide()
