@tool
## Allows the user to drop a [Resource] for use by the quest.
class_name ResourceDropZone extends Button

@onready var original_text = text
@onready var load_resource_file_dialog: FileDialog = $LoadResourceFileDialog

var quest_resource: Object:
	set(value):
		quest_resource = value
		if quest_resource == null:
			text = original_text
			return
		if quest_resource is Resource:
			if not quest_resource.resource_name.is_empty():
				text = quest_resource.resource_name
			else:
				text = quest_resource.resource_path.get_file()
		else:
			text = original_text
var previous_path = ""


func _ready() -> void:
	pressed.connect(_on_button_pressed)
	load_resource_file_dialog.file_selected.connect(_on_resource_file_selected)


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if typeof(data) != TYPE_DICTIONARY:
		return false
	if data.has("type") and data["type"] == "files" and data.has("files"):
		var file_path = data["files"][0]
		
		return true
	
	return false


func _drop_data(at_position: Vector2, data: Variant) -> void:
	var file_path = data["files"][0]
	_on_resource_file_selected(file_path)


func _on_button_pressed() -> void:
	load_resource_file_dialog.show()


func _on_resource_file_selected(path: String) -> void:
	var command := AssignResourceCommand.new(self, path, previous_path)
	command.execute()
	previous_path = path
	#var loaded_resource = load(path)
	#
	#if loaded_resource:
		#quest_resource = loaded_resource
