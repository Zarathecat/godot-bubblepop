extends Node

@export var bubble_scene: PackedScene
@export var starting_bubbles = 5

# If ever I figure out how to exit fullscreen on the desktop without
# killing the godot process, I'll make this game fullscreened by default
var window_size = DisplayServer.window_get_size()

var score = 0

# This one's less of a game and more of a prototype of a game.
# It's supposed to be played on a touchscreen. Not tested on one yet.
# It should eventually have different levels. Each level, there's a
# timer. This counts down and player must hit x many buttons before it
# hits 0, or perish. Each level, the required bubblecount goes up.
# I'd also like to have bubbles in different colours, and have a nice
# animation and sound when they pop, to make it more satisfying for the
# player. They should just fade out if they timeout on their own.
# For now, it's more like a bubblewrap game with no challenge.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide the game over message
	$Hud/EndText.hide()
	# make 5 bubbles at the start of the game!
	for i in range(starting_bubbles):
		generate_bubble()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# score is calculated per bubble, then combined!
	$Hud/Countdown.text = str(int($EndGameTimer.time_left))

# For now, we make a few random bubbles at the start
func generate_bubble():
	var bubble_position = get_random_position(window_size)
	var bubble = bubble_scene.instantiate()
	bubble.position = bubble_position
	bubble.add_to_group("bubbles")
	# Need to connect here or signals won't be passed through!
	bubble.bubble_pop.connect(_on_bubble_bubble_pop)
	add_child(bubble)

# I should probably be reusing these components between games
# by importing them...	
func get_random_position(win_size):
	var win_x = int(win_size[0])
	var win_y = int(win_size[1])
	var rand_pos_x = randi_range(0, win_size[0])
	var rand_pos_y = randi_range(0, win_size[1])
	return Vector2(rand_pos_x, rand_pos_y)

func display_score():
	$Hud/Score.text = str(score)


func _on_bubble_bubble_pop() -> void:
	score+= 1
	display_score()

func _on_end_game_timer_timeout() -> void:
	$EndGameTimer.stop()
	$NewGameTimer.start()
	$Hud/Score.hide()
	$Hud/EndText.text ="Game over!\n Score: " + str(score)
	$Hud/EndText.show()

func _on_new_game_timer_timeout() -> void:
	score = 0
	display_score()
	$Hud/EndText.hide()
	$Hud/Score.show()
	$EndGameTimer.start()
