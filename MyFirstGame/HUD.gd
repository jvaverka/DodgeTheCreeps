extends CanvasLayer


signal start_game

# This function displays a message temporarily.
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

# This function is called when the Player loses.
# Show "Game Over" for 2 seconds, then return to title screen,
# and after a short pause show the "Start Game" button.
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	# Display title screen once again.
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

# Call this function whenever score changes.
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
