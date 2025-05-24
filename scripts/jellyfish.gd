extends Enemy

@export var _targetPoint:Node2D

var _movingTo:Array[Vector2] = [];

func _ready():
	super._ready()
	if (_targetPoint):
		_movingTo.push_back(_targetPoint.global_position);
		_movingTo.push_back(position);
		position.x = randf_range(position.x, _targetPoint.global_position.x)
		position.y = randf_range(position.y, _targetPoint.global_position.y)

func _process(_delta: float) -> void:
	if (_movingTo.size() == 0 || !alive):
		return;
		
	var target = _movingTo[0];
	velocity = position.direction_to(target) * _speed;

	if (position.distance_squared_to(target) < 1):
		_movingTo.pop_front();
		_movingTo.push_back(target);
	
	move_and_slide()

func _physics_process(_delta: float) -> void:
	pass


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'death':
		self.queue_free();


func _on_area_2d_body_entered(body: Character) -> void:
	if (body.is_in_group("Player") && alive):
		set_collision_layer_value(2, false);
		alive = false;
		bounce_character(body)
