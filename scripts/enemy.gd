extends CharacterBody2D


const SPEED = 200.0

var bullet := preload("res://scenes/fire.tscn")
@onready var player = get_node("/root/World/Player")

signal attack_signal(damage: int)

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
	
	fireshot_L.connect("attack_by_fire", attack) || fireshot_R.connect("attack_by_fire", attack)


func _physics_process(delta):
	# Add the gravity.
	global_position.y += SPEED * delta / 2


func _on_shoot_timer_timeout():
	shoot()
	
func attack():
	var damage = 1
	emit_signal("attack_signal", damage)
	

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		attack()



func _on_area_2d_area_entered(area):
	#print(area.name)
	pass
