@icon("uid://m35w8ws377d3")
## Helper class to create and add actions when a plugin is activated, and
## likewise remove actions when the plugin is deactivated.
## 
## Plugin Example Code:
## [codeblock]
## @tool
## extends EditorPlugin
##
## const AUTOLOAD_CAMERA_2D_SIGNAL_BUS = "Camera2DSignalBus"
## const MOVE_UP = "move_up"
## const MOVE_DOWN = "move_down"
## const MOVE_LEFT = "move_left"
## const MOVE_RIGHT = "move_left"
## const JUMP = "jump"
## const FIRE = "fire"
##
##
## func _enable_plugin() -> void:
##	InputMapAction.add(MOVE_UP, InputMapAction.joy_axis(JOY_AXIS_LEFT_Y, InputMapAction.AXIS_UP), InputMapAction.key(KEY_UP), InputMapAction.key(KEY_W))
##	InputMapAction.add(MOVE_DOWN, InputMapAction.joy_axis(JOY_AXIS_LEFT_Y, InputMapAction.AXIS_DOWN), InputMapAction.key(KEY_DOWN), InputMapAction.key(KEY_S))
##	InputMapAction.add(MOVE_LEFT, InputMapAction.joy_axis(JOY_AXIS_LEFT_X, InputMapAction.AXIS_LEFT), InputMapAction.key(KEY_LEFT), InputMapAction.key(KEY_A))
##	InputMapAction.add(MOVE_RIGHT, InputMapAction.joy_axis(JOY_AXIS_LEFT_X, InputMapAction.AXIS_RIGHT), InputMapAction.key(KEY_RIGHT), InputMapAction.key(KEY_D))
##	InputMapAction.add(JUMP, InputMapAction.joy_button(JOY_BUTTON_A), InputMapAction.mouse_button(MOUSE_BUTTON_RIGHT), InputMapAction.key(KEY_SPACE))
##	InputMapAction.add(FIRE, InputMapAction.joy_axis(JOY_AXIS_TRIGGER_RIGHT), InputMapAction.mouse_button(MOUSE_BUTTON_LEFT), InputMapAction.key(KEY_CTRL))
##	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")
##	EditorInterface.restart_editor()
##
##
## func _disable_plugin() -> void:
##	InputMapAction.remove(MOVE_UP)
##	InputMapAction.remove(MOVE_DOWN)
##	InputMapAction.remove(MOVE_LEFT)
##	InputMapAction.remove(MOVE_RIGHT)
##	InputMapAction.remove(JUMP)
##	InputMapAction.remove(FIRE)
##	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")
##	EditorInterface.restart_editor()
## [/codeblock]
class_name InputMapAction extends Object

const AXIS_UP = -1
const AXIS_DOWN = 1
const AXIS_LEFT = -1
const AXIS_RIGHT = 1


## Returns an [InputEventJoypadMotion] event. Valid [param input] values are in
## [enum @GlobalScope.JoyAxis]. Valid [param direction] values are
## [member AXIS_UP], [member AXIS_DOWN], [member AXIS_LEFT], and
## [member AXIS_RIGHT]. [param device] indicates which gamepad device this
## action listens to and defaults to -1 (all gamepad devices).
static func joy_axis(input: JoyAxis, direction: int = 0, device: int = -1) -> InputEventJoypadMotion:
	var event = InputEventJoypadMotion.new()
	event.axis = input
	event.axis_value = direction
	event.device = device
	return event


## Returns an [InputEventJoypadButton] event. Valid [param input] values are in
## [enum @GlobalScope.JoyButton]. [param device] indicates which gamepad device
## this action listens to and defaults to -1 (all gamepad devices).
static func joy_button(input: JoyButton, device: int = -1) -> InputEventJoypadButton:
	var event = InputEventJoypadButton.new()
	event.button_index = input
	event.device = device # -1 is all devices
	return event


## Returns an [InputEventKey] event. Valid [param input] values are in
## [enum @GlobalScope.Key].
static func key(input: Key) -> InputEventKey:
	var event = InputEventKey.new()
	event.physical_keycode = input
	return event


## Returns an [InputEventMouseButton] event. Valid [param input] values are in
## [enum @GlobalScope.MouseButton]. [param device] indicates which pointer
## device this action listens to and defaults to -1 (all pointer devices).
static func mouse_button(input: MouseButton, device: int = -1) -> InputEventMouseButton:
	var event = InputEventMouseButton.new()
	event.button_index = input
	event.device = device # -1 is all devices
	return event


## Adds [param action] to the [InputMap]. The [param events] argument accepts
## [float], [InputEventJoypadButton], [InputEventJoypadMotion], [InputEventKey],
## and [InputEventMouseButton]. It will ignore everything else.
## [br][br]
## If a [float] is provided, the deadzone for the controller 
## will be set to that value.
## [br][br]
## Supported [InputEvent]s can be passed by using the functions
## [method joy_axis], [method joy_button], [method key],
## and [method mouse_button]. Alternately, they can be created manually
## and passed in.
## 
## [codeblock]
## const MOVE_UP = "move_up"
##
## InputMapAction.add(MOVE_UP, InputMapAction.joy_axis(JOY_AXIS_LEFT_Y, InputMapAction.AXIS_UP), InputMapAction.key(KEY_UP), InputMapAction.key(KEY_W))
## [/codeblock]
static func add(action: StringName, ...events: Array) -> void:
	var input_map = {
		"deadzone": 0.2,
		"events": []
	}
	
	InputMap.add_action(action)
	
	for event in events:
		if event is float:
			input_map["deadzone"] = event
			InputMap.action_set_deadzone(action, event)
		elif event is InputEvent:
			InputMap.action_add_event(action, event)
			input_map["events"].append(event)
	
	ProjectSettings.set_setting("input/" + action, input_map)
	ProjectSettings.save()


## Removes an action and all associated [InputEvent]s from the [InputMap].
## 
## [codeblock]
## const MOVE_UP = "move_up"
##
## InputMapAction.remove(MOVE_UP)
## [/codeblock]
static func remove(action: StringName) -> void:
	InputMap.erase_action(action)
	ProjectSettings.set_setting("input/" + action, null)
	ProjectSettings.save()
