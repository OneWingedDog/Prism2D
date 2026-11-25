extends Node2D
# w lurks

@onready var speed = 1200
var airborne: bool = false
var cam_jump: bool = false
var has_collision: bool = false #only true when the embaressed animation is playing
var can_move: bool = false

var player: CharacterBody2D
var playerPOS: Vector2
