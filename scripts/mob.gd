extends CharacterBody2D

# Battle scene to load when the player encounters the enemy
@export var battle_scene : PackedScene

# Current health of the enemy
@export var salud = 100

# Maximum health of the enemy
@export var salud_maxima = 100

# Reference to the enemy animation player
@onready var animationOrc = $AnimationEnemies

# Reference to the enemy sprite (must be named Sprite2D)
@onready var sprite = $Sprite2D

# Indicates whether the enemy is alive
var esta_vivo = true

# Indicates whether the enemy is currently attacking
var atacando = false

func _ready():
	# Register this enemy in the game manager
	Manager.mob_node = self
	
	# Initialize health to maximum
	salud = salud_maxima
	
	# Wait one frame to ensure the UI is fully loaded
	await get_tree().process_frame
	
	# Look for the enemy health bar by its correct name: EnemyProgressBar
	var barra_vida = get_tree().current_scene.find_child("EnemyProgressBar", true, false)
	if barra_vida:
		# Configure the health bar values
		barra_vida.max_value = salud_maxima
		barra_vida.value = salud
	
	# Start with the idle animation if available
	if animationOrc:
		animationOrc.play("orc_idle")

func recibir_danio(cantidad: int):
	# Do nothing if the enemy is already dead
	if not esta_vivo: return
	
	# Reduce health by the received damage
	salud -= cantidad
	
	# Update the EnemyProgressBar UI
	var barra_vida = get_tree().current_scene.find_child("EnemyProgressBar", true, false)
	if barra_vida:
		barra_vida.value = salud
	
	# Print current enemy health for debugging
	print("Orc Health: ", salud)
	
	if salud <= 0:
		# Mark the enemy as dead and trigger death logic
		esta_vivo = false
		morir_orco()
	else:
		# Flash the sprite in red to indicate damage taken
		sprite.modulate = Color.RED
		await get_tree().create_timer(0.2).timeout
		sprite.modulate = Color.WHITE

func morir_orco():
	# Player victory message
	print("YOU WIN")
	
	# Play death animation if it exists
	if animationOrc.has_animation("orc_death"):
		animationOrc.play("orc_death")
		await animationOrc.animation_finished
	
	# Requested delay of 4 seconds before changing scene
	await get_tree().create_timer(4.0).timeout
	
	# Change to the winner scene
	get_tree().change_scene_to_file("res://escenas/winner.tscn") # change scene

func _on_detection_area_body_entered(body: Node2D) -> void:
	# Check if the body that entered the area is the player
	if body.name == "player":
		# Print to console to confirm the encounter works
		print("Enemy encounter! Switching to battle...")
		
		if battle_scene:
			# Change to the assigned battle scene
			get_tree().change_scene_to_packed(battle_scene)
		else:
			# Error message if the battle scene was not assigned in the inspector
			print("Error: 'battle_scene' has not been assigned in the Mob inspector")

func ejecutar_ataque_visual(nombre_anim: String):
	# 1. Intentamos reproducir el sonido correspondiente
	# Si nombre_anim es "orc_attack1", buscará el nodo de sonido "orc_attack1"
	var nodo_sonido = get_node_or_null(nombre_anim)
	
	if nodo_sonido:
		nodo_sonido.play()
	else:
		# Imprime un aviso en la consola si el nodo no existe, pero no rompe el juego
		print("Aviso: No se encontró el nodo de sonido: ", nombre_anim)

	# 2. Lógica de animación original
	if animationOrc.has_animation(nombre_anim):
		atacando = true
		
		animationOrc.play(nombre_anim)
		print("Orc is executing: ", nombre_anim)
		
		await animationOrc.animation_finished
		
		atacando = false
		animationOrc.play("orc_idle")
	else:
		print("Error: Animation does not exist ", nombre_anim)
		await get_tree().create_timer(1.0).timeout

func _process(_delta):
	# If the enemy is attacking or dead, do nothing
	if atacando or not esta_vivo:
		return
		
	# If no animation is playing, force the idle animation
	if animationOrc and not animationOrc.is_playing():
		animationOrc.play("orc_idle")
