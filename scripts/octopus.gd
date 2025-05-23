extends Enemy
var move_dir = 1;

func _process(delta: float) -> void:
	#detect cliff and turn around here
	
	run(move_dir);
	if (move_dir < 0):
		face_left()
	elif (move_dir > 0):
		face_right();
