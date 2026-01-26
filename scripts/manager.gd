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
	# Verificamos que ambos existan y estén vivos
	if mob_node and mob_node.esta_vivo and player_node and player_node.vivo:
		
		# Elegimos aleatoriamente entre ataque 1 y ataque 2 (50% de probabilidad cada uno)
		var eleccion = randi_range(1, 2)
		var nombre_ataque = "orc_attack" + str(eleccion)
		
		# Ejecutamos la animación y el sonido (usando tu función anterior)
		await mob_node.ejecutar_ataque_visual(nombre_ataque)
		
		# Lógica de probabilidad de acierto y daño
		var random_hit = randf() # Genera un número entre 0 y 1
		
		if eleccion == 1:
			# Ataque 1: 90% de probabilidad (0.9) y 20 de daño
			if random_hit <= 0.9:
				player_node.recibir_danio(20)
				print("¡Orc Attack 1 acertó! Daño: 20")
			else:
				print("¡Orc Attack 1 falló!")
				
		elif eleccion == 2:
			# Ataque 2: 40% de probabilidad (0.4) y 80 de daño
			if random_hit <= 0.4:
				player_node.recibir_danio(80)
				print("¡CRÍTICO! Orc Attack 2 acertó! Daño: 80")
			else:
				print("¡Orc Attack 2 falló!")
		
		# Cambiar de turno tras el ataque
		change_turn()
