@tool
class_name QuestResourceFormatSaver extends ResourceFormatSaver


func _recognize(resource: Resource) -> bool:
	return resource is Quest


func _get_recognized_extensions(resource: Resource) -> PackedStringArray:
	return PackedStringArray(["quest"])


func _save(resource: Resource, path: String, flags: int) -> Error:
	var quest: Quest
	if resource is Quest:
		quest = resource
	else:
		return ERR_INVALID_PARAMETER
	
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_pascal_string(quest.name)
	file.store_pascal_string(quest.description)
	file.close()
	return OK
