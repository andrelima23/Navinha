extends Node2D


@export var score = 999999
var health = 3

@onready var label = $Block_A/Score as Label
@onready var hearts = $Block_B/hearts as AnimatedSprite2D
@onready var player = get_node("/root/World/Player");

func _ready():
	player.connect("health_change", _on_health_change)
	health = player.health
	hearts.play("full")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str("Pontos ",score)
	
	var enemy_group = get_tree().get_nodes_in_group("Enemies")
	
func _on_health_change():
	health = player.health
	if health == 3:
		hearts.play("full")
	if health == 2:
		hearts.play("2_hearts")
	if health == 1:
		hearts.play("1_heart")
	if health < 1:
		hearts.play("empty")
