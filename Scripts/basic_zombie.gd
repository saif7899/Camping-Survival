extends CharacterBody2D

@export var speed = 130
@export var health = 100

@export var damage = 10
@export var attackRange = 30
@export var attackCooldown = 1

var campfire = null
var attacktimer = 0
@export var spawnCost = 1

@onready var agent: NavigationAgent2D = $NavigationAgent2D

# FOR POLISH
# vibarte when flashlight pointed
# some visual indication of lost health (like the zombie hunching down)
# proper death effect

# add proper pathfinding later

func _ready() -> void:
	campfire = get_tree().get_first_node_in_group("Campfire")
	attacktimer = randf_range(0, attackCooldown)
	await get_tree().physics_frame
	if campfire:
		agent.target_position = campfire.global_position

func _physics_process(delta: float) -> void:
	if !campfire:
		return
	
	var desired = Vector2.ZERO 
	
	var dist = global_position.distance_to(campfire.global_position)
	if dist > attackRange:
		if !agent.is_navigation_finished():
			agent.target_position = campfire.global_position
			desired = global_position.direction_to(agent.get_next_path_position()) * speed
	else: 
		velocity = Vector2.ZERO
		attacktimer -= delta
		if attacktimer <= 0:
			attack()
			attacktimer = attackCooldown
	
	agent.velocity = desired

func attack():
	if campfire and campfire.has_method("TakeDamage"):
		campfire.TakeDamage(damage)
		#animation and stuff 

func TakeDamage(amount: float):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()
	# death effects


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
