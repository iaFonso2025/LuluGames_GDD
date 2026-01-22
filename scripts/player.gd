extends CharacterBody2D

# Movement speed of the player
const SPEED = 300.0

# Reference to the player's AnimationPlayer
@onready var animationPlayer = $AnimationPlayer

# Reference to the player's sprite
@onready var sprite2D = $Sprite2D

# Current health of the player
@export var salud = 100

# Maximum health of the player
@export var salud_maxima = 100

# Indicates whether the player is currently attacking
var atacando = false

# Indicates whether the player is alive (blocks movement and animations when false)
var vivo = true 

func _ready() -> void:
	# Mandatory registration so the attack button can work
	Manager.player_node = self
	
	# Configure the health bar when entering battle
	await get_tree().process_frame 
	var barra = get_tree().current_scene.find_child("PlayerProgressBar", true, false)
	if barra:
		# Set the maximum value of the health bar
		barra.max_value = salud_maxima
		# Fill the bar with the initial health value
		barra.value = salud

func _physics_process(delta):
	# If the player is dead, do not process movement or animations
	if not vivo: 
		return

	# Check if the current scene is the battle scene
	var esta_en_batalla = get_tree().current_scene.name == "BattleScene"
	var direction = 0
	
	# Only allow movement when not in battle
	if not esta_en_batalla:
		direction = Input.get_axis("ui_left", "ui_right")
	
	# Corrected velocity calculation to prevent movement during battle
	velocity.x = direction * SPEED 
	
	# Apply movement
	move_and_slide()
	
	# Handle animations based on movement direction
	animations(direction)
	
	# Flip the sprite depending on movement direction
	if direction != 0:
		sprite2D.flip_h = (direction == -1)

func animations(direction):
	# Do nothing if the player is dead or attacking
	if not vivo or atacando: 
		return
		
	# Play idle or run animation depending on movement
	if direction == 0:
		animationPlayer.play("idle")
	else:
		animationPlayer.play("run")

func recibir_danio(cantidad: int):
	# Do nothing if the player is already dead
	if not vivo: return
	
	# Reduce player health
	salud -= cantidad
	
	# Update the PlayerProgressBar with the new health value
	var barra = get_tree().current_scene.find_child("PlayerProgressBar", true, false)
	if barra:
		barra.value = salud 
	
	# Print current player health for debugging
	print("Player Health: ", salud)
	
	# Flash the sprite in red to indicate damage taken
	sprite2D.modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	sprite2D.modulate = Color.WHITE
	
	if salud <= 0:
		# Trigger death logic when health reaches zero
		morir()

func _on_panel_gui_input(event: InputEvent) -> void:
	# Open the action menu if the player is alive, clicks the mouse, and it is the player's turn
	if vivo and Input.is_action_just_pressed("mouse_left") and Manager.turn_player:
		$Acciones.open_menu()

func abrir_menu_ataque():
	# Only allow opening the menu if the enemy is alive
	if vivo and Manager.mob_node and Manager.mob_node.esta_vivo:
		$Acciones.open_menu()

func morir():
	# Mark the player as dead
	vivo = false
	
	# Defeat message
	print("YOU LOST")
	
	# Play death animation if it exists
	if animationPlayer.has_animation("death"):
		animationPlayer.play("death")
		await animationPlayer.animation_finished
	
	# Wait 4 seconds before restarting the scene
	await get_tree().create_timer(4.0).timeout
	
	# Change back to the arena scene
	get_tree().change_scene_to_file("res://escenas/arena.tscn") # scene name
	
func ejecutar_ataque(id_ataque: int):
	# Build the attack animation name using the attack ID
	var nombre_anim = "ataque" + str(id_ataque)
	
	if animationPlayer.has_animation(nombre_anim):
		# Block other animations while attacking
		atacando = true
		
		# Stop any previous animation
		animationPlayer.stop()
		
		# Play the attack animation
		animationPlayer.play(nombre_anim)
		print("Visually executing: ", nombre_anim)
		
		# Wait until the attack animation finishes
		await animationPlayer.animation_finished
		
		# Unlock animations and return to idle
		atacando = false
		animationPlayer.play("idle")
	else:
		# Error message if the animation does not exist
		print("Error: Animation does not exist ", nombre_anim)
