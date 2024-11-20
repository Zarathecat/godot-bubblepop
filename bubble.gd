# This weird choice is because I wanted to set the position directly.
# CharacterBody2D lets you change it by going "position =" . Other
# types of physics body, eg: RigidBody2D, would not let me do this.
extends CharacterBody2D

var score = 0

var window_size = DisplayServer.window_get_size()

signal bubble_pop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#print(str(score))
	
func get_random_position(win_size):
	var win_x = int(win_size[0])
	var win_y = int(win_size[1])
	var rand_pos_x = randi_range(0, win_size[0])
	var rand_pos_y = randi_range(0, win_size[1])
	return Vector2(rand_pos_x, rand_pos_y)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		hide()
		score += 1
		bubble_pop.emit()
		#position = get_random_position(window_size)
		# Timer before new bubble appears
		$NewBubbleTimer.wait_time = randf()
		$NewBubbleTimer.start()
		# Timer for the new bubble to hang around
		$Timer.wait_time = randf_range(1, 5)
		$Timer.start()
		
	# here for now while test on desktop	
	else:
		$AnimatedSprite2D.play()
		score += 1
		bubble_pop.emit()
		$CollisionShape2D.disabled = true
		#position = get_random_position(window_size)
		# Timer before new bubble appears
		$NewBubbleTimer.wait_time = randf_range(0.5,2)
		$NewBubbleTimer.start()
		# Timer for the new bubble to hang around
		$Timer.wait_time = randf_range(2.1, 5)
		$Timer.start()

# Move bubble to a new location if player too slow to hit it in time		
func _on_timer_timeout() -> void:
	position = get_random_position(window_size)

func _on_new_bubble_timer_timeout() -> void:
	position = get_random_position(window_size)
	$AnimatedSprite2D.set_frame_and_progress(0,0)
	$CollisionShape2D.disabled = false
	
	
