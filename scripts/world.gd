class_name World
extends Node2D

@onready var player_scene = preload("res://scenes/player.tscn")
var cell_size = Data.cell_size_number
var level: TileMap
var player: Player

const STARTING_TILES_VAR_ID = [3, 7, 6, 5]
const EMPTY_TILE_ATLAS_COORDS = Vector2i(5,3)


func _ready():
  level = setup_level()
  setup_players()

  for i in range(1, 5):
    level.set_cell(0, get_starting_cell_for_player(i), 4, EMPTY_TILE_ATLAS_COORDS)

  add_child(level)
  add_child(player)
  player.captured.connect(_on_player_captured)

func setup_level():
  var level_scene = load("res://scenes/world/level_1.tscn")
  return level_scene.instantiate()


func setup_players():
  player = player_scene.instantiate()
  var player_number = player.player_number
  var starting_cell = get_starting_cell_for_player(player_number)
  player.position = starting_cell * cell_size + Vector2i(cell_size/2, cell_size/2)
  

func get_starting_cell_for_player(player_number):
  var result = level.get_used_cells_by_id(0, 4, EMPTY_TILE_ATLAS_COORDS, STARTING_TILES_VAR_ID[player_number - 1]).front()
  #print("player " + str(player_number) + " starting position = " + str(result.x) + "/" + str(result.y))
  return result


func _on_player_captured(player_number, capture_scene, pos):
  var capture = capture_scene.instantiate()
  capture.player = player
  capture.position = pos
  level.add_sibling(capture)
  Data.set_captured_cell_for_player(player_number, pos)
