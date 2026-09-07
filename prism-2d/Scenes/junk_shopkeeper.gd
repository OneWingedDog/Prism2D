extends Node2D

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@export var hard_can_interact: bool = true
var can_interact = false
var current_dialogue = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and hard_can_interact:
		can_interact = true
		print("inside npc ",)


func _on_timer_timeout() -> void:
	if animated_sprite_2d.animation != "fall asleep":
		animated_sprite_2d.play("fall asleep")
		pass
	elif animated_sprite_2d.animation == "fall asleep":
		animated_sprite_2d.play("wake up!!")
		await animated_sprite_2d.animation_finished
		timer.start()
		animated_sprite_2d.play("idle")
