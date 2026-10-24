extends Area2D

@export var dps = 20

func _physics_process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Zombie") and body.has_method("TakeDamage"):
			body.TakeDamage(dps * delta)
