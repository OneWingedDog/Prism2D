extends CharacterBody2D

var health: = 10
var vulnerable: bool = true
var dead: bool = false


@onready var camera_2d: Camera2D = $Camera2D

const tile_size: Vector2 = Vector2(64, 64)
var sprite_node_pos_tween: Tween
@export var camera_on: bool = true

func _ready() -> void:
	position = position.snapped(tile_size)
	if not camera_on:
		$Camera2D.enabled = false

func _physics_process(delta: float) -> void:
	if !sprite_node_pos_tween or !sprite_node_pos_tween.is_running():
		if Input.is_action_just_pressed("Up") and !$Up.is_colliding():
			_move(Vector2(0, -1))
		elif Input.is_action_just_pressed("Down") and !$Down.is_colliding():
			_move(Vector2(0, 1))
		elif Input.is_action_just_pressed("Right") and !$Right.is_colliding():
			_move(Vector2(1, 0))
		elif Input.is_action_just_pressed("Left") and !$Left.is_colliding():
			_move(Vector2(-1, 0))
	if health <= 0:
		queue_free()
			
			
func _move(dir: Vector2):
	global_position += dir * tile_size
	$AnimatedSprite2D.global_position -= dir * tile_size
	
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property($AnimatedSprite2D, "global_position", global_position, 0.185).set_trans(Tween.TRANS_SINE)


func take_damage(amount: int):
	if vulnerable and not dead:
		health -= amount
		print(health)
	#if health <= 0:
		#death()
	
