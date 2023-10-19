extends Node2D

var Enemy = preload("res://scenes/enemy.tscn")
var spawn_positions = null

signal make_damage(damage: int)

func _ready():
	spawn_positions = $positions.get_children()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func enemies():
	var index = randi() % spawn_positions.size()
	if index != randi() % spawn_positions.size():
		var enemy = Enemy.instantiate()
		
		enemy.connect("attack_signal", _make_damage)
		enemy.get
		enemy.global_position = spawn_positions[index].position
		add_child(enemy)


func _on_spawn_timer_timeout():
	enemies()

func _make_damage(damage):
	emit_signal("make_damage", damage)
