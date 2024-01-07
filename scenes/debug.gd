extends CanvasLayer

@onready var m_NodeFramesPerSecond: Label = $DebugBox/DebugParams/FPS/FPSValue
@onready var m_NodeCharacterState: Label = $DebugBox/DebugParams/CharacterState/CSValue
@onready var m_NodeCaptureTime: Label = $DebugBox/DebugParams/CaptureTime/CTValue
 
# Set the frames per second text on the top left corner of the screen
func _physics_process(delta) -> void:
	m_NodeFramesPerSecond.set_text(str(Engine.get_frames_per_second()))
	
func SetCaptureTime(time: float) -> void:
	m_NodeCaptureTime.set_text(str(time))
	
# Set the character state text on the top left corner of the screen
func SetCharacterState(text : String) -> void:
	m_NodeCharacterState.set_text(text)
