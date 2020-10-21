extends RigidBody2D


export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.

# We'll randomly pick a speed and animation for each enemy.
func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

# delete enemy when they leave screen.
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
