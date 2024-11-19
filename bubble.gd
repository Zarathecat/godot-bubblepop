extends CharacterBody2D

var score = 0

var window_size = DisplayServer.window_get_size()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_random_position(win_size):
	var win_x = int(win_size[0])
	var win_y = int(win_size[1])
	var rand_pos_x = randi_range(0, win_size[0])
	var rand_pos_y = randi_range(0, win_size[1])
	return Vector2(rand_pos_x, rand_pos_y)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print(event)
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		print("Bubble popped!")
		position = get_random_position(window_size)
		score += 1
