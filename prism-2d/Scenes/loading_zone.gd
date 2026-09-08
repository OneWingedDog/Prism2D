extends Area2D


@export var scene_to_load = PackedScene.new()

@export var active: bool = true



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_packed(scene_to_load)
