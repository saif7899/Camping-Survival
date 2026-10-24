extends Node2D

#todo
# let it spawn multiple TYPES of zombies
#limit the amount of zombies
# let us damage the zombies
# let them hurt the campfire

@export var zombieScene: PackedScene # to be dragged in (make this into an array later)
@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	if not zombieScene:
		return #so that no errors show up when it's null
	
	var zombie = zombieScene.instantiate()
	var viewportSize = get_viewport_rect().size
	var spawn_x = -20
	var spawn_y = randf_range(100, viewportSize.y - 100)
	zombie.global_position = Vector2(spawn_x,spawn_y)
	get_tree().current_scene.add_child(zombie)
