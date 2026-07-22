@tool
@icon("uid://cu1tcdypslmjy")
class_name QuestsMainPanel extends PanelContainer

var undo_queue: Array[Command]
var redo_queue: Array[Command]
# When this is on, we let the Editor handle Undo/redo requets. This is so we do
# not need to re-implement them for LineEdit and TextEdit nodes which already
# have implementations, and we do not have to store a ton of minor text changes.
var is_bypass_undo_redo_on: bool = false

@onready var graphs: GraphTabContainer = %Graphs


func _ready() -> void:
	Quests.execute.connect(_on_execute_command)
	Quests.undo.connect(_on_undo_command)
	Quests.redo.connect(_on_redo_command)
	Quests.bypass_undo_redo.connect(_on_bypass_undo_redo)
	# Needed to not throw errors on "save_quest" and "load_quest" actions
	# when the panel is embedded in the editor.
	InputMap.load_from_project_settings()


func _on_execute_command(command: Command) -> void:
	undo_queue.append(command)


func _on_undo_command() -> void:
	var command: Command = undo_queue.pop_back()
	if command:
		command.undo()
		redo_queue.append(command)


func _on_redo_command() -> void:
	var command: Command = redo_queue.pop_back()
	if command:
		command.execute()


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_undo", false, true) and not is_bypass_undo_redo_on:
		Quests.undo.emit()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("ui_redo", false, true) and not is_bypass_undo_redo_on:
		Quests.redo.emit()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("save_quest", false, true):
		graphs.save_current_quest()
	elif event.is_action_pressed("load_quest", false, true):
		graphs.load_quest()
		get_viewport().set_input_as_handled()


func _on_bypass_undo_redo(on: bool) -> void:
	is_bypass_undo_redo_on = on
