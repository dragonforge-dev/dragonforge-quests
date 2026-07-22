class_name ConnectQuestNodeCommand extends Command

var quest_graph_edit: QuestGraphEdit
var from_node: StringName
var from_port: int
var to_node: StringName
var to_port: int


func _init(quest_graph_edit: QuestGraphEdit, from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	self.quest_graph_edit = quest_graph_edit
	self.from_node = from_node
	self.from_port = from_port
	self.to_node = to_node
	self.to_port = to_port


func execute() -> void:
	quest_graph_edit.connect_node(from_node, from_port, to_node, to_port)
	Quests.execute.emit(self)


func undo() -> void:
	quest_graph_edit.disconnect_node(from_node, from_port, to_node, to_port)
