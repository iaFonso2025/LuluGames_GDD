extends Control

# Handles global input events (keyboard and mouse)
func _input(event: InputEvent) -> void:
	# If the player presses any key or mouse button, the intro is skipped
	if event is InputEventKey or event is InputEventMouseButton:
		# Check if the input event is a press action
		if event.pressed:
			# Switch to the arena scene
			cambiar_a_arena()

# Changes the current scene to the arena
func cambiar_a_arena() -> void:
	# Load the arena scene to start the game
	get_tree().change_scene_to_file("res://escenas/arena.tscn")
