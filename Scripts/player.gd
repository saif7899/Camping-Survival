extends CharacterBody2D

@export var speed = 350
var targetPosition = Vector2.ZERO

func _ready() -> void:
	targetPosition = global_position

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("Left Mouse"):
		targetPosition = get_global_mouse_position()
	var direction = global_position.direction_to(targetPosition)
	var distance = global_position.distance_to(targetPosition)
	
	if distance > 5: 
		velocity = direction *speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
	$flashlight.look_at(get_global_mouse_position())
