class_name AssignResourceCommand extends Command

# The [ResourceDropZone] [Control] which is having a [Resource] assigned.
var resource_drop_zone: ResourceDropZone
# The path for the new [Resource].
var path: String
# The path for the previous [Resource] for undoing.
var previous_path: String


func _init(resource_drop_zone: ResourceDropZone, path: String, previous_path: String) -> void:
	self.resource_drop_zone = resource_drop_zone
	self.path = path
	self.previous_path = previous_path


func execute() -> void:
	if path:
		var loaded_resource = load(path)
		if loaded_resource:
			resource_drop_zone.quest_resource = loaded_resource
		Quests.execute.emit(self)
	else:
		resource_drop_zone.quest_resource = null


func undo() -> void:
	if previous_path:
		var loaded_resource = load(previous_path)
		if loaded_resource:
			resource_drop_zone.quest_resource = loaded_resource
	else:
		resource_drop_zone.quest_resource = null
