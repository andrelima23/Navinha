extends CharacterBody2D


const SPEED = 200.0

var bullet := preload("res://scenes/fire.tscn")

func get_input():
	var fire = Input.is_action_just_pressed("fire")
	
		
	if fire:
		shoot()

func shoot():
	var fireshot_L = bullet.instantiate()
	var fireshot_R = bullet.instantiate()
	
	fireshot_L.position = $gun_L.global_position
	fireshot_R.position = $gun_R.global_position
	fireshot_L.is_enemy = true
	fireshot_R.is_enemy = true
	
	var sprite2DL = fireshot_L.get_node("Sprite2D") as Sprite2D
	var sprite2DR = fireshot_R.get_node("Sprite2D") as Sprite2D
	sprite2DL.scale = Vector2(0.3,0.3)
	sprite2DR.scale = Vector2(0.3,0.3)
	get_parent().add_child(fireshot_L)
	get_parent().add_child(fireshot_R)


func _physics_process(delta):
	
	var player = get_node("/root/World/Player")
	var enemy1 = get_node("/root/World/init_enemies/Enemy")
	var player_position = Vector2.ZERO
	var player_positionY = 0
	var player_positionX = 0
	
	#global_position.x = 500
	if player:
		player_positionY += global_position.y * SPEED * delta / 2
		player_positionX += player.global_position.x
		player_position = global_position.direction_to(Vector2(player_positionX, player_positionY)).normalized()
	
	global_position += player_position * SPEED * delta / 2

func _on_shoot_timer_timeout():
	shoot()
	
	
