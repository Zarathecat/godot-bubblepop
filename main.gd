extends Node

@export var bubble_scene: PackedScene

var window_size = DisplayServer.window_get_size()

# I want a timer attached to each bubble, that moves it
# when the time runs out. Not sure how to attach a timer to
# a node like that, yet. Assume I make it a child of the bubble
# node? So, for bubble in bubbles, timer.new(), and name it to
# map to the bubble? or have a dict with bubbles and timers as keys
# and values?
# Yeah I think I should add a timer as part of the bubble node.
# I also want each bubble to move when a player presses it
# I *think* that should also reset its timer, but maybe it's more
# lively if it doesn't.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# make 5 bubbles at the start of the game!
	for i in range(5):
		generate_bubble()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# For now, we make a few random bubbles at the start
func generate_bubble():
	var bubble_position = get_random_position(window_size)
	var bubble = bubble_scene.instantiate()
	bubble.add_to_group("bubbles")
	add_child(bubble)

# I should probably be reusing these components between games
# by importing them...	
func get_random_position(win_size):
	var win_x = int(win_size[0])
	var win_y = int(win_size[1] + 50)
	var rand_pos_x = randi_range(0, win_size[0])
	return Vector2(rand_pos_x, win_y)

func _on_rigid_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print(event.position)
