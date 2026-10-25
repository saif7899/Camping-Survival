extends Area2D

@export var dps = 20
@export var shakeStrength = 1

func _physics_process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Zombie") and body.has_method("TakeDamage"):
			body.TakeDamage(dps * delta)
			body.position += Vector2(randf_range(-shakeStrength, shakeStrength), randf_range(-shakeStrength, shakeStrength))
