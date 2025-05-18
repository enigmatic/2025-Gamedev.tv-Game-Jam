extends CharacterBody2D

@export var _faceRight: bool = true;

@export_category("Locomotion")
@export var _speed = 8;
@export var _acceleration : float = 16
@export var _deceleration : float = 32

@export_category("Jump")
@export var  _jump_height : float = 2.5;
@export var _air_control : float = 0.01;
var _jump_velocity: float;

@onready var _sprite : AnimatedSprite2D = $AnimatedSprite2D;

var _direction: float;

func _ready():
	_acceleration *= Global.ppt;
	_deceleration *= Global.ppt;
	_speed *= Global.ppt;
	_jump_height *= Global.ppt;
	var default_gravity = ProjectSettings.get_setting("physics/2d/default_gravity");
	_jump_velocity = sqrt(_jump_height * default_gravity * 2) * -1

#region Public Methods
func face_left():
	_sprite.flip_h = !_faceRight;
	return;
	
func face_right():
	_sprite.flip_h = _faceRight;
	return;
	
func run(direction: float):
	_direction = direction;
	
func jump():
	if is_on_floor():
		velocity.y = _jump_velocity
		
func stop_jump():
	if velocity.y < 0:
		velocity.y = 0;

#endregion

#region Private Methods
func _physics_process(delta: float):
	if sign(_direction) == 1:
		face_left();
	elif sign(_direction) == -1:
		face_right();
		
	if is_on_floor():
		_ground_physics(delta);
	else:
		_air_physics(delta);
	
	move_and_slide()
		
func _ground_physics(delta: float):

	if _direction == 0:
		velocity.x = move_toward(velocity.x, 0, _deceleration * delta)
	elif velocity.x == 0 || sign(_direction) == sign(velocity.x):
		velocity.x = move_toward(velocity.x, _direction * _speed, _acceleration * delta);
	else:
		velocity.x = move_toward(velocity.x, _direction * _speed, _deceleration * delta);

func _air_physics(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if _direction == 0:
		velocity.x = move_toward(velocity.x, 0, _deceleration * delta * _air_control)
	elif velocity.x == 0 || sign(_direction) == sign(velocity.x):
		velocity.x = move_toward(velocity.x, _direction * _speed, _acceleration * delta * _air_control);
	else:
		velocity.x = move_toward(velocity.x, _direction * _speed, _deceleration * delta * _air_control);

#endregion
