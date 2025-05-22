extends CharacterBody2D

class_name Character

@export var _faceRight: bool = true;

@export_category("Locomotion")
@export var _speed = 3;
@export var _acceleration : float = 32
@export var _deceleration : float = 48

@export_category("Jump")
@export var  _jump_height : float = 1;
@export var _air_control : float = 0.5;
@export var _max_underwater_fall:int = 4;
var _jump_velocity: float;

@onready var _sprite : AnimatedSprite2D = $AnimatedSprite2D;

var alive: bool = true;

var _direction: float;
var _underWater: bool = true;

func _ready():
	_acceleration *= Global.ppt;
	_deceleration *= Global.ppt;
	_speed *= Global.ppt;
	_jump_height *= Global.ppt;
	_max_underwater_fall *= Global.ppt;
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
	if alive:
		_direction = direction;
	
func jump():
	if alive && is_on_floor():
		velocity.y = _jump_velocity
		
func stop_jump():
	if alive && velocity.y < 0:
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
		var water_mul:float = 1.0;
		if (velocity.y > 0 && _underWater):
			water_mul = 0.25

		velocity += get_gravity() * delta * water_mul;

	if _direction == 0:
		velocity.x = move_toward(velocity.x, 0, _deceleration * delta * _air_control)
	elif velocity.x == 0 || sign(_direction) == sign(velocity.x):
		velocity.x = move_toward(velocity.x, _direction * _speed, _acceleration * delta * _air_control);
	else:
		velocity.x = move_toward(velocity.x, _direction * _speed, _deceleration * delta * _air_control);

#endregion


func _on_aquarium_in_water():
	velocity.y = velocity.y / 4
	_underWater = true;

func _on_aquarium_out_of_water():
	_underWater = false;

func kill():
	alive = false;
	_direction = 0;
	set_collision_layer_value(3, false)
