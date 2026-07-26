extends Node

var cloose_game_when_it_opens: bool = false

func close_game():
	if cloose_game_when_it_opens:
		close_game()

func _process(delta: float) -> void:
	close_game()
