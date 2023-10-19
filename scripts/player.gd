extends CharacterBody2D

@export var speed = 350
@export var health = 3
var direction = Vector2()
var invulnerability_time = 1.4
var is_invulnerable = false
var last_hit_time = 0

@onready var anim := $animNavinha as AnimatedSprite2D
@onready var animator = $Animator as AnimationPlayer

signal health_change
var bullet := preload("res://scenes/fire.tscn")


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	var fire = Input.is_action_just_pressed("fire")
	
	velocity = input_direction * speed
	
	if input_direction.x == -1:
		anim.play("turn_l")
	elif input_direction.x == 1:
		anim.play("turn_r")
	else:
		anim.play("default")
		
	if fire:
		shoot()
		
func shoot():
	var fireshot = bullet.instantiate()
	
	fireshot.position = $gun_C.global_position;
	get_parent().add_child(fireshot)
	fireshot.connect("attack_by_player", attack)
	

func _ready():
	var enemy = get_node("/root/World//init_enemies")
	var fire = get_node("/root/World//init_enemies")
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	move_and_slide()
	
	if is_invulnerable:
		# Se estiver invulnerável, atualiza o tempo desde o último dano
		var current_time = Time.get_ticks_msec() / 1000.0  # Converte os milissegundos para segundos
		var time_since_last_hit = current_time - last_hit_time
		
		# Se o tempo de invulnerabilidade acabou, desativa a invulnerabilidade
		if time_since_last_hit >= invulnerability_time:
			is_invulnerable = false
			
	if health < 1:
		anim.play("damaged")

func _on_enemy_attack_signal(damage):
	#_on_protect_timer_timeout()
	pass
	
	#health -= damage

func _on_init_enemies_make_damage(damage):	
	# Verifica se o personagem não está em estado de invulnerabilidade
	if not is_invulnerable:
		health -= damage
		last_hit_time = Time.get_ticks_msec() / 1000.0  # Registra o tempo do último dano
		is_invulnerable = true  # Ativa o estado de invulnerabilidade
		emit_signal("health_change")
		animator.play("damaged")

func attack(body: CharacterBody2D):
	print('funcao atackk')
	if body.is_in_group("Enemies"):
		print('Ataquei um inimigo')
		
	
