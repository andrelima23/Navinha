extends Sprite2D

@onready var sprite = $ParallaxLayer/bg as Sprite2D;
var initial_position: Vector2

func _ready():
	initial_position = position  # Salva a posição inicial
	
func _physics_process(delta):
	position.y += 0.25
	
	if position.y > -1:
		position = initial_position
	
