extends Node2D

#todo
#limit the amount of zombies
# let us damage the zombies
# let them hurt the campfire

@export var zombieScene: Array[PackedScene] # to be dragged in 

@export var baseBudget = 3
@export var budgetPerWave = 2
@export var timeBetweenWaves = 20
@export var spawnDelay = 3
@export var maxZombies = 40

var wave = 0
var waveTimer = 5
var spawnTimer = 0
var budget = 0 

func _process(delta: float) -> void:
	waveTimer -= delta
	if waveTimer <= 0:
		waveTimer = timeBetweenWaves
		wave += 1
		budget += baseBudget +budgetPerWave * wave # might remove *wave
	
	if budget > 0:
		spawnTimer -= delta
		if spawnTimer <= 0:
			SpawnZombie()

func SpawnZombie():
	if get_tree().get_nodes_in_group("Zombie").size() >= maxZombies:
		return
	var zombie = zombieScene.pick_random().instantiate()
	
	if zombie.spawnCost > budget:
		zombie.free()
		budget = 0
		return
	budget -= zombie.spawnCost
	zombie.global_position = Vector2(-20,randf_range(100, get_viewport_rect().size.y - 50))
	get_tree().current_scene.add_child(zombie)
	spawnTimer = spawnDelay

#func _on_timer_timeout() -> void:
	#if not zombieScene:
		#return #so that no errors show up when it's null
	#
	#var zombie = zombieScene.instantiate()
	#var viewportSize = get_viewport_rect().size
	#var spawn_x = -20
	#var spawn_y = randf_range(100, viewportSize.y - 100)
	#zombie.global_position = Vector2(spawn_x,spawn_y)
	#get_tree().current_scene.add_child(zombie)
