extends Node

# Indicates whether it is the player's turn
var turn_player : bool = true

# Reference to the player node (assigned automatically)
var player_node

# Reference to the enemy (orc) node (assigned automatically)
var mob_node

# Switches the turn between player and enemy
func change_turn():
	# Toggle turn: player <-> enemy
	turn_player = !turn_player
	
	# Print whose turn it is
	print("Current turn: ", "Player" if turn_player else "Enemy")
	
	if !turn_player:
		# If it is not the player's turn, wait a moment and let the enemy attack
		await get_tree().create_timer(1.2).timeout
		enemy_attack_logic()

# Handles the enemy attack logic
func enemy_attack_logic():
	# Check that both enemy and player exist and are alive
	if mob_node and mob_node.esta_vivo and player_node and player_node.vivo:
		# Play the orc attack animation
		await mob_node.ejecutar_ataque_visual("orc_attack1")
		
		# Apply damage to the player
		player_node.recibir_danio(15) 
		
		# Change back to the player's turn after the attack
		change_turn()
