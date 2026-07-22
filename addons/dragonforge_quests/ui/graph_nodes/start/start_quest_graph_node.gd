@tool
class_name StartQuestGraphNode extends GraphNode

## The name of the quest.
@onready var quest_name: LineEdit = $QuestName
## The quest description.
@onready var quest_description: TextEdit = $QuestDescription

# The starting name of the quest, and also the previous name in case submitting
# the quest name gets undone.
var previous_name: String = "New Quest"
# The [Resource] this [Quest] is stored inside.
var quest: Quest


func _ready() -> void:
	quest = Quest.new()
	quest_name.text_changed.connect(_on_quest_name_changed)
	quest_name.text_submitted.connect(_on_quest_name_submitted)
	quest_description.text_changed.connect(_on_quest_description_changed)


func _on_quest_name_submitted(new_text: String) -> void:
	var command := QuestNameSubmittedCommand.new(previous_name, new_text, self, get_parent())
	command.execute()
	previous_name = quest_name.text


func _on_quest_name_changed(new_text: String) -> void:
	quest.name = new_text


func _on_quest_description_changed() -> void:
	quest.description = quest_description.text


func save_quest(save_path: String) -> void:
	quest.name = quest_name.text
	
	# Save the quest object.
	ResourceSaver.save(quest, save_path)


func load_quest(load_path: String) -> void:
	quest = ResourceLoader.load(load_path)
	quest_name.text = quest.name
	previous_name = quest.name
	quest_description.text = quest.description
