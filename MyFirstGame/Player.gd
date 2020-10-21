extends Area2D

signal hit
export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

func _ready():
	# Find the size of the game window.
	screen_size = get_viewport_rect().size
	# Hide Player when game starts.
	hide()

func _process(delta):
	# What the player will do.
	# For us, this means:
	#   1. Check for input.
	#   2. Move in a given direction.
	#   3. Play the appropriate animation.
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	# Clamp - or restrict the position to a given range.
	# You know, so it stays on the screen.
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	# Fix the animations for the direction Player is moving.
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

# Emit a hit signal when Player enters another rigid body.
func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

# Reset Player's start postion at the beginning of new game.
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
