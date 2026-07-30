extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var detonation_timer: Timer = $DetonationTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	countdown()

func countdown():
	detonation_timer.start()
	
func _process(delta: float) -> void:
	if detonation_timer.time_left <= 2:
		animated_sprite_2d.play ("Flashing")

func _on_detonation_timer_timeout() -> void:
	var overlap_body: Array[Node2D] = area_2d.get_overlapping_bodies()

	for body in area_2d.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(2)
		else:
			push_error("Player dosen't have take damage method. FUCK")
	animated_sprite_2d.play ("Damage")
	await animated_sprite_2d.animation_finished
	queue_free()

	
func destroy_node():
	var danger_tile = get_parent()
	if is_instance_valid(danger_tile) and not danger_tile.is_queued_for_deletion():
		danger_tile.queue_free()
