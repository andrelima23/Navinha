extends Node2D

var is_enemy = false
var direction = -1
var speed = 800;

@onready
var sprite2D = $Sprite2D as Sprite2D
signal attack_by_fire
signal attack_by_player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += direction * speed * delta
	
	if position.y > 700 || position.y < -700:
		queue_free()
	
	if is_enemy:
		direction = 1
		
			
func attack(who: String):
	if who == "Enemy":
		emit_signal("attack_by_fire")
	if who == "Player":
		emit_signal("attack_by_player")
		
		
func _on_area_2d_body_entered(body):
	print('aqui ',body.name)
	if body.name == "Player":
		attack("Enemy")
	if body.is_in_group("Enemies"):
		attack("Player")
