extends Node

var cell_size_number: int = 64
var cell_size = Vector2i(cell_size_number, cell_size_number)
var captured_cells = [[], [], [], []]


func set_captured_cell_for_player(player_number: int, pos: Vector2i) -> void:
	var cell = cell_coords(pos)
	captured_cells[player_number - 1].append(cell)


func get_captured_cells_for_player(player_number: int) -> Array:
	return captured_cells[player_number - 1]


func cell_coords(pos: Vector2i):
	var x = pos.x
	var y = pos.y
	return Vector2i(pos.x/cell_size.x, pos.y/cell_size.y)
