extends State
class_name PlayerMove

@export var player: Player

@onready var movement_validation: RayCast2D = %MovementValidation
@onready var movement_tween: Node = %MovementTween

var tile_size: int
var animation_speed: float
var global_position: Vector2
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

func Enter():
	tile_size = player.tile_size
	animation_speed = player.animation_speed
	global_position = player.global_position

func Exit():
	player.moving = false

func Update(delta: float):
	if not player.moving:
		for key in inputs.keys():
			if Input.is_action_pressed(key): move(key)

func move(dir):
	if movement_validation.validate_movement(inputs[dir] * tile_size):
		player.moving = true
		Debug.SetCharacterState('Moving %s' % dir)
		movement_tween.move_time = 1.0/animation_speed
		movement_tween.run(player, global_position + inputs[dir] * tile_size)
		await movement_tween.tween.finished
		Debug.SetCellPosition(global_position, tile_size)
		Transitioned.emit(self, 'idle')
