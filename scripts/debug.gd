extends CanvasLayer

@onready var m_NodeCharacterState: Label = $Control/DebugBox/DebugParams/CharacterState/CSValue
@onready var m_NodeCaptureTime: Label = $Control/DebugBox/DebugParams/CaptureTime/CTValue
@onready var m_NodeCanCapture: Label = $Control/DebugBox/DebugParams/CanCapture/CCValue
	

func SetCaptureTime(capture_time: int) -> void:
	m_NodeCaptureTime.set_text(str(capture_time))

	
# Set the character state text on the top left corner of the screen
func SetCharacterState(text : String) -> void:
	m_NodeCharacterState.set_text(text)


func SetCanCapture(can_capture: bool) -> void:
	var can_capture_string = "true" if can_capture else "false"
	m_NodeCanCapture.set_text(can_capture_string)