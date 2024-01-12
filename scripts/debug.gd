extends CanvasLayer

@onready var m_NodeCharacterState: Label = $Control/DebugBox/DebugParams/CharacterState/CSValue
@onready var m_NodeCaptureTime: Label = $Control/DebugBox/DebugParams/CaptureTime/CTValue
@onready var m_NodeCellPositionX: Label = $Control/DebugBox/DebugParams/CellPositionX/CPXValue
@onready var m_NodeCellPositionY: Label = $Control/DebugBox/DebugParams/CellPositionY/CPYValue
	

func SetCaptureTime(capture_time: int) -> void:
	m_NodeCaptureTime.set_text(str(capture_time))
	

func SetCellPosition(pos: Vector2i, tile_size: int) -> void:
	m_NodeCellPositionX.set_text(str(pos.x) + "/" + str(pos.x/tile_size))
	m_NodeCellPositionY.set_text(str(pos.y) + "/" + str(pos.y/tile_size))
	
	
# Set the character state text on the top left corner of the screen
func SetCharacterState(text : String) -> void:
	m_NodeCharacterState.set_text(text)
