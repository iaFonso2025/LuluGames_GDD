extends Control

# Handles GUI input events (mouse, keyboard, etc.)
func _gui_input(event: InputEvent) -> void:
	# Detect if the user performs a left mouse click
	if event is InputEventMouseButton:
		# Check if the left mouse button is pressed
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Restart the game when the button is clicked
			reiniciar_juego()

# Restarts the game by loading the arena scene again
func reiniciar_juego() -> void:
	# Print a message to the console to confirm the click was detected
	print("Game Over button pressed: Restarting...")
	
	# Change to the arena scene to start the game again
	get_tree().change_scene_to_file("res://escenas/arena.tscn")
