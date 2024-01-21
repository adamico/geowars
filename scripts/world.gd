class_name World
extends Node2D

@onready var player_scene = preload("res://scenes/player/player.tscn")
var cell_size: int = Data.cell_size_number
var level: TileMap
var level_number: int
var player: Player

const LEVEL_PLAYER_STARTING_CELLS = [
  [
    Vector2i(1,1),
    Vector2i(17,17),
    Vector2i(1,17),
    Vector2i(17,1),
  ],  
  [
    Vector2i(1,1),
    Vector2i(17,17),
    Vector2i(1,17),
    Vector2i(17,1),
  ],
  [
    Vector2i(1,9),
    Vector2i(17,9),
    Vector2i(9,17),
    Vector2i(9,1),
  ],
  [
    Vector2i(1,1),
    Vector2i(17,17),
    Vector2i(1,17),
    Vector2i(17,1),
  ]
]

const LEVEL_PLAYER_ORIGINAL_CELLS = [
  [
    Vector2i(1,1),
    Vector2i(3,3),
    Vector2i(1,3),
    Vector2i(3,1)
  ],
  [
    Vector2i(8,9),
    Vector2i(11,12),
    Vector2i(8,12),
    Vector2i(11,9)
  ],
  [
    Vector2i(1,2),
    Vector2i(3,2),
    Vector2i(2,3),
    Vector2i(2,1)
  ],
  [
    Vector2i(8,9),
    Vector2i(11,12),
    Vector2i(8,12),
    Vector2i(11,9)
  ]
]

const ATLAS_SOURCE_ID = 0
const VOID_LAYER = 0
const LEVEL_LAYER = 1
const CAPTURE_LAYER = 2
const CAPTURED_PLAYER_CELLS = [
  Vector2i(1,0),
  Vector2i(2,0),
  Vector2i(3,0),
  Vector2i(4,0)
]

func _ready():
  level = setup_level()
  level.set_layer_modulate(VOID_LAYER, Color(0,0,0,0)) # make VOID_LAYER transparent
  setup_player()
  reset_player_cells()

  add_child(level)
  add_child(player)
  player.captured.connect(_on_player_captured)

func get_level():
  return level

func setup_level():
  level_number = Data.level
  var level_scene = load("res://scenes/world/level_%d.tscn" % level_number)
  return level_scene.instantiate()


func setup_player():
  player = player_scene.instantiate()
  var player_number = player.player_number
  player.position = get_starting_coords_for_player(player_number) * cell_size + Vector2i(cell_size/2, cell_size/2)


func reset_player_cells():
  for i in range(1,5):
    level.set_cell(LEVEL_LAYER, get_starting_coords_for_player(i), ATLAS_SOURCE_ID, LEVEL_PLAYER_ORIGINAL_CELLS[level_number-1][i-1])  


func get_starting_coords_for_player(player_number):
  return LEVEL_PLAYER_STARTING_CELLS[level_number-1][player_number-1]


func _on_player_captured(player_number, pos):
  var captured_cell_coords = pos / Vector2(cell_size,cell_size)
  level.set_cell(LEVEL_LAYER, captured_cell_coords, ATLAS_SOURCE_ID, CAPTURED_PLAYER_CELLS[player_number-1])
  Data.set_captured_cell_for_player(player_number, pos)
