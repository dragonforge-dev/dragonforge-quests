@tool
class_name QuestResourceFormatLoader extends ResourceFormatLoader


func _get_recognized_extensions() -> PackedStringArray:
	return PackedStringArray(["quest"])


func _handles_type(type: StringName) -> bool:
	return type == "Resource"


func _get_resource_script_class(path: String) -> String:
	if path.get_extension() == "quest":
		return "Quest"
	return ""


func _get_resource_type(path: String) -> String:
	if path.get_extension() == "quest":
		return "Resource"
	return ""


func _load(path: String, original_path: String, use_sub_threads: bool, cache_mode: int) -> Variant:
	
	var quest: Quest = Quest.new()
	
	var file := FileAccess.open(path, FileAccess.READ)
	
	quest.name = file.get_pascal_string()
	quest.description = file.get_pascal_string()
	
	return quest
