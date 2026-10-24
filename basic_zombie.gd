extends CharacterBody2D

@export var speed = 150
@export var health = 100

var campfire = null

# FOR POLISH
# vibarte when flashlight pointed
# some visual indication of lost health (like the zombie hunching down)
# proper death effect

# add proper pathfinding later

func _ready() -> void:
	add_to_group("zombies")
	campfire = get_tree().get_first_node_in_group("Campfire")
	
func _physics_process(delta: float) -> void:
	if campfire:
		var dir = global_position.direction_to(campfire.global_position)
		velocity = dir * speed
	else: velocity = Vector2.ZERO
	move_and_slide()

func TakeDamage(amount: float):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()
	# death effects
