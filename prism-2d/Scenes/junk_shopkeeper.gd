extends Node2D

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D



func _on_timer_timeout() -> void:
	if animated_sprite_2d.animation == "idle":
		animated_sprite_2d.play("fall asleep")
	elif animated_sprite_2d.animation == "fall asleep":
		animated_sprite_2d.play("wake up!!")
	elif animated_sprite_2d.animation == "wake up!!":
		await animated_sprite_2d.animation_finished
		timer.start()
		animated_sprite_2d.play("idle")
