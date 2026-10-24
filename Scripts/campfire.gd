extends Area2D

@export var maxHealth = 200
@onready var health = maxHealth

func TakeDamage(amount: float):
	health -= amount
	if health <= 0:
		GameOver()

func GameOver():
	print("campfire died")
	# switch to a lose screen
