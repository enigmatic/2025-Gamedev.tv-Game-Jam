extends Enemy
var move_dir = 1;

@onready var raycast = $AnimatedSprite2D/RayCast2D

func _process(_delta: float) -> void:
	if (!alive):
		return;
		
	#detect cliff and turn around here
	if !raycast.is_colliding() and is_on_floor():
		move_dir *= -1; #turn around
		raycast.target_position.x *= -1;
	
	if (move_dir < 0):
		face_left()
	elif (move_dir > 0):
		face_right();
		
	run(move_dir);


func _on_hurt_box_body_entered(body):
	
	if (body.is_in_group("Player") && alive):
		set_collision_layer_value(2, false);
		run(0);
		velocity.x = 0;
		alive = false;
		bounce_character(body)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'death':
		self.queue_free();
