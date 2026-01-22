extends Control

# Opens the combat menu by making it visible
func open_menu():
	visible = true

# Closes the combat menu by hiding it
func close_menu():
	visible = false

# Called when the node is ready
# The menu starts closed by default
func _ready() -> void:
	close_menu()

# Light Attack Button: 20 damage, 100% hit chance
func _on_b_atack_1_button_down() -> void:
	# Check if it is the player's turn and the enemy is alive
	if Manager.turn_player and Manager.mob_node.esta_vivo:
		# Close the menu after selecting the attack
		close_menu()
		
		# This attack always hits (100%), no random calculation needed
		await Manager.player_node.ejecutar_ataque(1)
		
		# Deal 20 damage to the enemy
		Manager.mob_node.recibir_danio(20)
		
		# Change turn after the attack
		Manager.change_turn()

# Heavy Attack Button: 45 damage, 60% hit chance
func _on_b_atack_2_button_down() -> void:
	# Check if it is the player's turn and the enemy is alive
	if Manager.turn_player and Manager.mob_node.esta_vivo:
		# Close the menu after selecting the attack
		close_menu()
		
		# Play the heavy attack animation
		await Manager.player_node.ejecutar_ataque(2)
		
		# Probability calculation (0.6 = 60% chance to hit)
		if randf() <= 0.6:
			print("Heavy attack hit!")
			
			# Deal 45 damage if the attack hits
			Manager.mob_node.recibir_danio(45)
		else:
			print("Heavy attack missed")
			
			# Optional: you could call a 'missed' function on the enemy
			
		# Change turn after the attack attempt
		Manager.change_turn()

# Ultimate Attack Button: 60 damage, 40% hit chance
func _on_b_atack_3_button_down() -> void:
	# Check if it is the player's turn and the enemy is alive
	if Manager.turn_player and Manager.mob_node.esta_vivo:
		# Close the menu after selecting the attack
		close_menu()
		
		# Play the ultimate attack animation
		await Manager.player_node.ejecutar_ataque(3)
		
		# Probability calculation (0.4 = 40% chance to hit)
		if randf() <= 0.4:
			print("ULTIMATE ATTACK HIT!")
			
			# Deal 60 damage if the attack hits
			Manager.mob_node.recibir_danio(60)
		else:
			print("Ultimate attack missed")
			
		# Change turn after the attack attempt
		Manager.change_turn()
