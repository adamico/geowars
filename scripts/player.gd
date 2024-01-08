extends Area2D


var moving: bool = false
var capturing: bool = false
var capture_time: float = 0.0

@export var animation_speed: int = 4
@export var tile_size: int
@export var capture_speed_multiplier = 1
@export var capture_duration: int = 3 / capture_speed_multiplier

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

@onready var ray = $RayCast2d
@onready var capture_scene = preload("res://scenes/capture.tscn")

func _process(delta):
	if !moving && !capturing: Debug.SetCharacterState("Idle")
	capturing = Input.is_action_pressed("capture")
	
	if capturing:
		capture_time += delta
		Debug.SetCharacterState("Capturing")

		if capture_time - capture_duration >= 0:
			capture_time = 0
		Debug.SetCaptureTime(round(capture_time))
	else:
		capture_time = 0

func _unhandled_input(event):
	if !moving:
		for dir in inputs.keys():
			if event.is_action_pressed(dir): move(dir)

func move(dir):
	Debug.SetCharacterState("Moving " + dir)
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		#$AnimationPlayer.play(dir)
		await tween.finished
		moving = false
		Debug.SetCellPosition(global_position, tile_size)

func capture():
	var capture = capture_scene.instantiate()
	capture.setup(global_position, capture_duration)
	get_node(^"../World").add_sibling(capture)
