extends Node2D

@export var frequency: float = 2.0

@export var Scene: PackedScene
@export var collision_tiles: PackedScene

@onready var timer: Timer = Timer.new()

var valid_cells: Array[Vector2]

func _ready() -> void:
	start_timer()
	
func start_timer():
		add_child(timer)
		timer.wait_time = frequency
		timer.timeout.connect(_on_timer_timeout)		timer.start()

# _on_timer_timeout():
	#spawn_threat()
	
#func spawn_threat():

	
