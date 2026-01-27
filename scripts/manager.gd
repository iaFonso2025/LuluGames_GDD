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
	# We verified that both exist and are alive.
	if mob_node and mob_node.esta_vivo and player_node and player_node.vivo:
		
		# We randomly choose between attack 1 and attack 2 (50% probability each)
		var eleccion = randi_range(1, 2)
		var nombre_ataque = "orc_attack" + str(eleccion)
		
		# We run the animation and sound (using your previous function)
		await mob_node.ejecutar_ataque_visual(nombre_ataque)
		
		# Logic of probability of success and damage
		var random_hit = randf() # Genera un número entre 0 y 1
		
		if eleccion == 1:
			# Attack 1: 90% chance (0.9) and 20 damage
			if random_hit <= 0.9:
				player_node.recibir_danio(20)
				print("¡Orc Attack 1 acertó! Daño: 20")
			else:
				print("¡Orc Attack 1 falló!")
				
		elif eleccion == 2:
			# Attack 2: 40% chance (0.4) and 80 damage
			if random_hit <= 0.4:
				player_node.recibir_danio(80)
				print("¡CRÍTICO! Orc Attack 2 acertó! Daño: 80")
			else:
				print("¡Orc Attack 2 falló!")
		
		# Change turns after the attack
		change_turn()
