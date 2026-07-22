class_name QuestNameSubmittedCommand extends Command

var previous_name: String
var new_name: String
var quest_graph_edit: QuestGraphEdit
var start_quest_graph_node: StartQuestGraphNode


func _init(previous_name: String, new_name: String, start_quest_graph_node: StartQuestGraphNode, quest_graph_edit: QuestGraphEdit) -> void:
	self.previous_name = previous_name
	self.new_name = new_name
	self.quest_graph_edit = quest_graph_edit
	self.start_quest_graph_node = start_quest_graph_node


func execute() -> void:
	quest_graph_edit.name = new_name
	start_quest_graph_node.quest_name.text = new_name
	Quests.execute.emit(self)


func undo() -> void:
	quest_graph_edit.name = previous_name
	start_quest_graph_node.quest_name.text = previous_name
