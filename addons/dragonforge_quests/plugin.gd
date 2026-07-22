@tool
extends EditorPlugin

const AUTOLOAD_QUESTS = "Quests"
const SAVE_QUEST_ACTION = "save_quest"
const LOAD_QUEST_ACTION = "load_quest"
const QUESTS_DOCK = preload("uid://b11g0mildc5aj")
const QUESTS_24_X_24 = preload("uid://cdydlvd8y3k6l")

var main_panel_instance: Control
var resource_format_saver: QuestResourceFormatSaver = QuestResourceFormatSaver.new()
var resource_format_loader: QuestResourceFormatLoader = QuestResourceFormatLoader.new()


func _enable_plugin() -> void:
	add_autoload_singleton(AUTOLOAD_QUESTS, "res://addons/dragonforge_quests/quests.gd")
	InputMapAction.add(SAVE_QUEST_ACTION, _get_save_key())
	InputMapAction.add(LOAD_QUEST_ACTION, _get_load_key(), _get_open_key())
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")
	ResourceSaver.add_resource_format_saver(resource_format_saver)
	ResourceLoader.add_resource_format_loader(resource_format_loader)


func _disable_plugin() -> void:
	remove_autoload_singleton(AUTOLOAD_QUESTS)
	InputMapAction.remove(SAVE_QUEST_ACTION)
	InputMapAction.remove(LOAD_QUEST_ACTION)
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")
	ResourceSaver.remove_resource_format_saver(resource_format_saver)
	ResourceLoader.remove_resource_format_loader(resource_format_loader)


func _enter_tree() -> void:
	await get_tree().create_timer(1.0).timeout #Giving the Quests autoload time to load.
	main_panel_instance = QUESTS_DOCK.instantiate()
	# Add the QuestsMainPanel to the editor's main viewport.
	# Requires overriding _has_main_screen(), _make_visible(),
	# _get_plugin_name(), and _get_plugin_icon() to work.
	EditorInterface.get_editor_main_screen().add_child(main_panel_instance)
	_make_visible(false)


func _exit_tree() -> void:
	if main_panel_instance:
		main_panel_instance.queue_free()


func _has_main_screen():
	return true


func _make_visible(visible):
	if main_panel_instance:
		main_panel_instance.visible = visible


# The name of the toolbar button added to the top of the window.
func _get_plugin_name():
	return "Quests"


# Passes an icon for the main screen. An icon is required, and 24x24 is the
# largest size possible without pushing the entire toolbar and menu down.
func _get_plugin_icon():
	return QUESTS_24_X_24


func _get_save_key() -> InputEventKey:
	var event = InputEventKey.new()
	event.keycode = Key.KEY_S
	event.ctrl_pressed = true
	return event


func _get_open_key() -> InputEventKey:
	var event = InputEventKey.new()
	event.keycode = Key.KEY_O
	event.ctrl_pressed = true
	return event


func _get_load_key() -> InputEventKey:
	var event = InputEventKey.new()
	event.keycode = Key.KEY_L
	event.ctrl_pressed = true
	return event
