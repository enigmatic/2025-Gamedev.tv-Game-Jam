extends Enemy

@export var _targetPoint:Node2D
@export var _speed = 3;

var _movingTo:Array[Vector2] = [];

func _ready():
	_speed *= Global.ppt;
	if (_targetPoint):
		_movingTo.push_back(_targetPoint.global_position);
		_movingTo.push_back(position);
		position.x = randf_range(position.x, _targetPoint.global_position.x)
		position.y = randf_range(position.y, _targetPoint.global_position.y)

func _process(_delta: float) -> void:
	if (_movingTo.size() == 0):
		return;
		
	var target = _movingTo[0];
	velocity = position.direction_to(target) * _speed;
#	position.x = move_toward(position.x, target.x, delta * _speed);
#	position.y = move_toward(position.y, target.y, delta * _speed);

	if (position.distance_squared_to(target) < 1):
		_movingTo.pop_front();
		_movingTo.push_back(target);
	
	move_and_slide()
